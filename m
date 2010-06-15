From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/5 v2] unpack_trees: group errors by type
Date: Tue, 15 Jun 2010 14:58:50 +0200
Message-ID: <vpqljagzc39.fsf@bauges.imag.fr>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 14:59:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVjP-00077f-Sl
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 14:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741Ab0FOM67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 08:58:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35109 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab0FOM66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 08:58:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5FColtN030553
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 15 Jun 2010 14:50:47 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OOVj8-0003P1-Tc; Tue, 15 Jun 2010 14:58:50 +0200
In-Reply-To: <1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr> (Diane Gasselin's message of "Tue\, 15 Jun 2010 14\:22\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 15 Jun 2010 14:50:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FColtN030553
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277211053.31522@HoUahmcg3HQiRwyCd/lZow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149180>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -60,6 +60,92 @@ static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
>  }
>  
>  /*
> + * add error messages on path <path> and action <action>
> + * corresponding to the type <e> with the message <msg>
> + * indicating if it should be display in porcelain or not
> + */
> +static int add_rejected_path(struct unpack_trees_options *o,
> +			     enum unpack_trees_error e,
> +			     const char *path,
> +			     const char *action,
> +			     int porcelain,
> +			     const char *msg)
> +{
> +	struct rejected_paths_list *newentry;
> +	struct rejected_paths **rp;
> +	/*
> +	 * simply display the given error message if in plumbing mode
> +	 */
> +	if (!porcelain)
> +		o->show_all_errors = 0;
> +	if (!o->show_all_errors)
> +		return error(msg, path, action);

I don't fully understand what you're doing with show_all_errors and
porcelain here. From the caller, "porcelain" is true iff the
corresponding error message has been set in o. But if you can infer
whether you're in porcelain from the error messages, why do you need
show_all_errors in addition?

>  static int reject_merge(struct cache_entry *ce, struct unpack_trees_options *o)
>  {
> -	return error(ERRORMSG(o, would_overwrite), ce->name);
> +	return add_rejected_path(o, would_overwrite, ce->name, NULL,
> +				 (o && (o)->msgs.would_overwrite),

Parenthesis around (o) are distracting and useless. I guess you
copy-pasted from a macro (for which parentheses should definitely be
used in case the macro is called on an arbitrary expression).

> @@ -874,8 +964,16 @@ static int verify_uptodate_1(struct cache_entry *ce,
>  	}
>  	if (errno == ENOENT)
>  		return 0;
> -	return o->gently ? -1 :
> -		error(error_msg, ce->name);
> +	if (error == sparse_not_uptodate_file)
> +		return o->gently ? -1 :
> +			add_rejected_path(o, sparse_not_uptodate_file, ce->name, NULL,
> +					  (o && (o)->msgs.sparse_not_uptodate_file),
> +					  ERRORMSG(o, sparse_not_uptodate_file));
> +	else
> +		return o->gently ? -1 :
> +			add_rejected_path(o, not_uptodate_file, ce->name, NULL,
> +					  (o && (o)->msgs.not_uptodate_file),
> +					  ERRORMSG(o, not_uptodate_file));
>  }

Isn't that a complex way of saying

	int porcelain;
	if (error == sparse_not_uptodate_file)
		porcelain = o && o->msgs.sparse_not_uptodate_file;
	else
		porcelain = o && o->msgs.not_uptodate_file;
	return o->gently ? -1 :
			add_rejected_path(o, error, ce->name, NULL,
					  porcelain, ERRORMSG(o, error));

?

Also, I'm not sure I understand why you're attaching the error message
string to each rejected_paths entry. Wouldn't it be more sensible to
use o->msg in display_error_msgs() instead?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
