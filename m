From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 01/11] replace: forbid replacing an object with one of a different type
Date: Sat, 31 Aug 2013 23:11:26 +0100
Organization: OPDS
Message-ID: <7D7C5D53BA544AAD92B05DF9635926C8@PhilipOakley>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org> <20130831191215.26699.18957.chriscool@tuxfamily.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Thomas Rast" <trast@inf.ethz.ch>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Christian Couder" <chriscool@tuxfamily.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 00:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFtNU-0003OL-9L
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 00:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239Ab3HaWKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 18:10:35 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:25782 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753290Ab3HaWKf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 18:10:35 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvULAFBpIlJOl3GZ/2dsb2JhbABagweJa7d9BAQBgR0XdIIfBQEBBAEIAQEuHgEBIQUGAgMFAgEDDgcMJRQBBBoGBxcGARIIAgECAwGHawq5a49/gySBAAOIfYYShQyVQIE6KYE+Ow
X-IPAS-Result: AvULAFBpIlJOl3GZ/2dsb2JhbABagweJa7d9BAQBgR0XdIIfBQEBBAEIAQEuHgEBIQUGAgMFAgEDDgcMJRQBBBoGBxcGARIIAgECAwGHawq5a49/gySBAAOIfYYShQyVQIE6KYE+Ow
X-IronPort-AV: E=Sophos;i="4.89,999,1367967600"; 
   d="scan'208";a="435716286"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip03ir2.opaltelecom.net with SMTP; 31 Aug 2013 23:10:32 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233550>

Sorry for not replying earlier in the series.

From: "Christian Couder" <chriscool@tuxfamily.org>
> Users replacing an object with one of a different type were not
> prevented to do so, even if it was obvious, and stated in the doc,
> that bad things would result from doing that.
>
> To avoid mistakes, it is better to just forbid that though.
>
> If one object is replaced with one of a different type, the only way
> to keep the history valid is to also replace all the other objects
> that point to the replaced object.

Isn't this a recursion problem? Taken in that order one unravels the 
whole DAG.

However if considered in the reverse direction, one can replace an 
existing object within the DAG with a carefully crafted alternative of 
the same type, but which then wrongly references other dangling objects 
which are then replaced by objects which have the right type (this last 
replacement requires -f force).

> That's because:
>
> * Annotated tags contain the type of the tagged object.
>
> * The tree/parent lines in commits must be a tree and commits, resp.
>
> * The object types referred to by trees are specified in the 'mode'
>  field:
>    100644 and 100755    blob
>    160000               commit
>    040000               tree
>  (these are the only valid modes)
>
> * Blobs don't point at anything.
>
> The doc will be updated in a later patch.
>
> Acked-by: Philip Oakley <philipoakley@iee.org>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> builtin/replace.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 59d3115..9a94769 100644
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
> @@ -100,6 +101,15 @@ static int replace_object(const char *object_ref, 
> const char *replace_ref,
>  if (check_refname_format(ref, 0))
>  die("'%s' is not a valid ref name.", ref);
>
> + obj_type = sha1_object_info(object, NULL);
> + repl_type = sha1_object_info(repl, NULL);
> + if (obj_type != repl_type)
> + die("Objects must be of the same type.\n"
> +     "'%s' points to a replaced object of type '%s'\n"
> +     "while '%s' points to a replacement object of type '%s'.",
> +     object_ref, typename(obj_type),
> +     replace_ref, typename(repl_type));
> +
>  if (read_ref(ref, prev))
>  hashclr(prev);
>  else if (!force)
> -- 
> 1.8.4.rc1.31.g530f5ce.dirty
>
>
> 
