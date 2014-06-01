From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v4 1/2] refs.c: optimize check_refname_component()
Date: Sun, 1 Jun 2014 20:43:27 +0100
Organization: OPDS
Message-ID: <26BF02A7C7E94EC5BE4CA28C409F0FAE@PhilipOakley>
References: <1401599865-14117-1-git-send-email-dturner@twitter.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "David Turner" <dturner@twitter.com>
To: "David Turner" <dturner@twopensource.com>,
	"Michael Haggerty" <mhagger@alum.mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 01 21:43:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrBfH-0002dU-QO
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 21:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbaFATn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 15:43:28 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:8394 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752512AbaFATn1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jun 2014 15:43:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmonAGCBi1MCYJNL/2dsb2JhbABZDoJ5ZYhsuiEFAQIBAQx9F3SCIAEEAQEFCAEBLh4BASELAgMFAgEDDgcMJRQBBBoGBxcGARIIAgECAwGFOAcBggtquDSdMheOUjWCfYEVBIlrhkqUZogSgnhBPA
X-IPAS-Result: AmonAGCBi1MCYJNL/2dsb2JhbABZDoJ5ZYhsuiEFAQIBAQx9F3SCIAEEAQEFCAEBLh4BASELAgMFAgEDDgcMJRQBBBoGBxcGARIIAgECAwGFOAcBggtquDSdMheOUjWCfYEVBIlrhkqUZogSgnhBPA
X-IronPort-AV: E=Sophos;i="4.98,952,1392163200"; 
   d="scan'208";a="460280856"
Received: from host-2-96-147-75.as13285.net (HELO PhilipOakley) ([2.96.147.75])
  by out1.ip05ir2.opaltelecom.net with SMTP; 01 Jun 2014 20:43:25 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250544>

From: "David Turner" <dturner@twopensource.com>
> In a repository with many refs, check_refname_component can be a major
> contributor to the runtime of some git commands. One such command is
>
> git rev-parse HEAD
>
> Timings for one particular repo, with about 60k refs, almost all
> packed, are:
>
> Old: 35 ms
> New: 29 ms
>
> Many other commands which read refs are also sped up.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
> refs.c | 68 
> ++++++++++++++++++++++++++++++++++++++++--------------------------
> 1 file changed, 41 insertions(+), 27 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 28d5eca..62e2301 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -5,9 +5,32 @@
> #include "dir.h"
> #include "string-list.h"
>
> +/* How to handle various characters in refnames:
> + * 0: An acceptable character for refs
> + * 1: End-of-component
> + * 2: ., look for a following . to reject .. in refs
> + * 3: @, look for a following { to reject @{ in refs
> + * 9: A bad character, reject ref
> + *
> + * See below for the list of illegal characters, from which
> + * this table is derived.

The "see below" doesn't quite scan right.  Perhaps
    The character handling rules above are used to
    derive the table below.

> + */
> +static unsigned char refname_disposition[] = {
> + 1, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> + 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> + 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 2, 1,
> + 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 9,
> + 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> + 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 9, 0,
> + 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> + 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 9, 9
> +};
> +
> /*
> - * Make sure "ref" is something reasonable to have under 
> ".git/refs/";
> - * We do not like it if:
> + * Try to read one refname component from the front of refname.
> + * Return the length of the component found, or -1 if the component 
> is
> + * not legal.  It is legal if it is something reasonable to have 
> under
> + * ".git/refs/"; We do not like it if:
>  *
>  * - any path component of it begins with ".", or
>  * - it has double dots "..", or
> @@ -15,24 +38,7 @@
>  * - it ends with a "/".
>  * - it ends with ".lock"
>  * - it contains a "\" (backslash)
> - */
>
> -/* Return true iff ch is not allowed in reference names. */
> -static inline int bad_ref_char(int ch)
> -{
> - if (((unsigned) ch) <= ' ' || ch == 0x7f ||
> -     ch == '~' || ch == '^' || ch == ':' || ch == '\\')
> - return 1;
> - /* 2.13 Pattern Matching Notation */
> - if (ch == '*' || ch == '?' || ch == '[') /* Unsupported */
> - return 1;
> - return 0;
> -}
> -
> -/*
> - * Try to read one refname component from the front of refname. 
> Return
> - * the length of the component found, or -1 if the component is not
> - * legal.
>  */
> static int check_refname_component(const char *refname, int flags)
> {
> @@ -40,17 +46,25 @@ static int check_refname_component(const char 
> *refname, int flags)
>  char last = '\0';
>
>  for (cp = refname; ; cp++) {
> - char ch = *cp;
> - if (ch == '\0' || ch == '/')
> + unsigned char ch = (unsigned char) *cp;
> + char disp = refname_disposition[ch];
> + switch(disp) {
> + case 1:
> + goto out;
> + case 2:
> + if (last == '.')
> + return -1; /* Refname contains "..". */
>  break;
> - if (bad_ref_char(ch))
> - return -1; /* Illegal character in refname. */
> - if (last == '.' && ch == '.')
> - return -1; /* Refname contains "..". */
> - if (last == '@' && ch == '{')
> - return -1; /* Refname contains "@{". */
> + case 3:
> + if (last == '@')
> + return -1; /* Refname contains "@{". */
> + break;
> + case 9:
> + return -1;
> + }
>  last = ch;
>  }
> +out:
>  if (cp == refname)
>  return 0; /* Component has zero length. */
>  if (refname[0] == '.') {
> -- 
> 2.0.0.rc1.18.gf763c0f
>
> --

Philip 
