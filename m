From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] replace: forbid replacing an object with one of a different type
Date: Thu, 8 Aug 2013 22:09:31 +0100
Organization: OPDS
Message-ID: <A88E12BCC58A401DBDD2EB300C1AAA2D@PhilipOakley>
References: <20130807044248.17464.35806.chriscool@tuxfamily.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>, "Thomas Rast" <trast@inf.ethz.ch>
To: "Christian Couder" <chriscool@tuxfamily.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7XSP-0004qx-9o
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966702Ab3HHVJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:09:13 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:55896 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966650Ab3HHVJL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Aug 2013 17:09:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlYMALoIBFJOl3GZ/2dsb2JhbABbgwaJV7VyBAQBgRkXdIIfBQEBBAEIAQEuHgEBIQsCAwUCAQMOBwELJRQBBBoGBxcGARIIAgECAwGHeQq4XpAbgyF0A4hzhg6aL4MZOw
X-IPAS-Result: AlYMALoIBFJOl3GZ/2dsb2JhbABbgwaJV7VyBAQBgRkXdIIfBQEBBAEIAQEuHgEBIQsCAwUCAQMOBwELJRQBBBoGBxcGARIIAgECAwGHeQq4XpAbgyF0A4hzhg6aL4MZOw
X-IronPort-AV: E=Sophos;i="4.89,841,1367967600"; 
   d="scan'208";a="438383089"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip01ir2.opaltelecom.net with SMTP; 08 Aug 2013 22:09:09 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231931>

From: "Christian Couder" <chriscool@tuxfamily.org>
Sent: Wednesday, August 07, 2013 5:42 AM
> Users replacing an object with one of a different type were not
> prevented to do so, even if it was obvious, and stated in the doc,
> that bad things would result from doing that.
>
> To avoid mistakes, it is better to just forbid that though.
>
> The doc will be updated in a later patch.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> If this patch is considered useful, I will update the doc and
> maybe add tests.

Acked-by: Philip Oakley <philipoakley@iee.org>
Improved documentation would always be useful.

>
> builtin/replace.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 59d3115..0246ab3 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -85,6 +85,7 @@ static int replace_object(const char *object_ref,
> const char *replace_ref,
>    int force)
> {
>  unsigned char object[20], prev[20], repl[20];
> + enum object_type obj_type, repl_type;
>  char ref[PATH_MAX];
>  struct ref_lock *lock;
>
> @@ -100,6 +101,14 @@ static int replace_object(const char *object_ref,
> const char *replace_ref,
>  if (check_refname_format(ref, 0))
>  die("'%s' is not a valid ref name.", ref);
>
> + obj_type = sha1_object_info(object, NULL);
> + repl_type = sha1_object_info(repl, NULL);

Do (very) large blobs have any issues here? As I understand it, such
blobs, as with other smaller objects, need to be expanded to determine
the type. Is there a heuristic (and is it worth it) to do a 'large
object == blob' initial check to avoid such an expansion? Small objects
shouldn't be an overhead.

Just a thought.

> + if (obj_type != repl_type)
> + die("Object ref '%s' is of type '%s'\n"
> +     "while replace ref '%s' is of type '%s'.",
> +     object_ref, typename(obj_type),
> +     replace_ref, typename(repl_type));

Perhaps start with "Objects must be of the same type.\n"

> +
>  if (read_ref(ref, prev))
>  hashclr(prev);
>  else if (!force)
> -- 
> 1.8.4.rc1.22.g132b1a0
