From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] replace: forbid replacing an object with one of a different type
Date: Wed, 7 Aug 2013 10:46:37 +0200
Message-ID: <87iozhyjki.fsf@linux-k42r.v.cablecom.net>
References: <20130807044248.17464.35806.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Aug 07 10:46:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6zOM-0007AB-IX
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 10:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157Ab3HGIqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 04:46:43 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:3761 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756924Ab3HGIqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 04:46:39 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 7 Aug
 2013 10:46:35 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.253) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 7 Aug 2013 10:46:36 +0200
In-Reply-To: <20130807044248.17464.35806.chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 7 Aug 2013 06:42:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231811>

Christian Couder <chriscool@tuxfamily.org> writes:

> Users replacing an object with one of a different type were not
> prevented to do so, even if it was obvious, and stated in the doc,
> that bad things would result from doing that.
>
> To avoid mistakes, it is better to just forbid that though.
>
> The doc will be updated in a later patch.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Feel free to steal some of my other email for the commit message, to
write down for posterity that reverting would not really be a useful
step.

The patch looks good to me.

> If this patch is considered useful, I will update the doc and
> maybe add tests.
>
>  builtin/replace.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 59d3115..0246ab3 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -85,6 +85,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>  			  int force)
>  {
>  	unsigned char object[20], prev[20], repl[20];
> +	enum object_type obj_type, repl_type;
>  	char ref[PATH_MAX];
>  	struct ref_lock *lock;
>  
> @@ -100,6 +101,14 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>  	if (check_refname_format(ref, 0))
>  		die("'%s' is not a valid ref name.", ref);
>  
> +	obj_type = sha1_object_info(object, NULL);
> +	repl_type = sha1_object_info(repl, NULL);
> +	if (obj_type != repl_type)
> +		die("Object ref '%s' is of type '%s'\n"
> +		    "while replace ref '%s' is of type '%s'.",
> +		    object_ref, typename(obj_type),
> +		    replace_ref, typename(repl_type));
> +
>  	if (read_ref(ref, prev))
>  		hashclr(prev);
>  	else if (!force)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
