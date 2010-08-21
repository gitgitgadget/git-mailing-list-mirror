From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/5] fmt-merge-msg: Make the number of log entries
 in commit message configurable
Date: Fri, 20 Aug 2010 22:54:03 -0500
Message-ID: <20100821035403.GA2474@burratino>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
 <1282331702-5115-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 05:56:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfBi-0003Re-Mn
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 05:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab0HUDzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 23:55:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47982 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab0HUDzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 23:55:51 -0400
Received: by ywe9 with SMTP id 9so862642ywe.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 20:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Z7BDCmDV+K1XCrgDNkMV+15PBtRAldwP/XOtGLhGUAU=;
        b=Pxnks7k/6CjMqoERRQNEiNGp8VrSxqs5J57ebIXlGkcwqyw2oVJpbqypBvf6I/S0p4
         zCjjp5IsfVGX/roowIWF1gW6ONWX6baWimgMkbnQxBpTzuTNpONuzKhmlsgbiJp78fU7
         pXUeGgWYLNK3GWMZ+QGC6/vid1flym7UE5e8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vYkzXCcbtffk7CRzY+vJ4N5aI+6lzEsZ5FbrHjsA46vJEYmG7+Q04oFzh7Nnu8TkfV
         84munewFJSW/DmLthdSAYW1C3o8brV97pucqioCH7QE7nFYFxBFuZKvFck8qlNITuFg8
         uAsPMgsjYTZlWxBOc+3cT0nQlOxFxvXWEjCi4=
Received: by 10.100.8.16 with SMTP id 16mr2566414anh.169.1282362950814;
        Fri, 20 Aug 2010 20:55:50 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id t30sm5738856ann.7.2010.08.20.20.55.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 20:55:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282331702-5115-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154095>

Ramkumar Ramachandra wrote:

> +++ b/builtin/fmt-merge-msg.c
> @@ -12,16 +12,23 @@ static const char * const fmt_merge_msg_usage[] = {
>  };
>  
>  static int merge_summary;
> +static int log_limit = 0;
>  
>  static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
>  {
>  	static int found_merge_log = 0;
> +	int is_bool = 0;
>  	if (!strcmp("merge.log", key)) {
>  		found_merge_log = 1;
> -		merge_summary = git_config_bool(key, value);
> +		log_limit = git_config_bool_or_int(key, value, &is_bool);
>  	}
>  	if (!found_merge_log && !strcmp("merge.summary", key))
> -		merge_summary = git_config_bool(key, value);
> +		log_limit = git_config_bool_or_int(key, value, &is_bool);
> +
> +	if (is_bool && log_limit)
> +		log_limit = 20;
> +	merge_summary = log_limit ? 1 : 0;

Hmm, this seems to be trying to have it both ways.  It would be simpler to
either:

	static int merge_summary;
	static int log_limit = 20;

providing independent internal "enabled" and "limit" knobs, so one could use,
say,

	[merge]
		log = 2
		log = false
		log = true

with the result being be a log_limit of 2, or

	static int log_limit;

where 0 means disabled, so in that example the result would be a log_limit
of 20.

> @@ -140,7 +147,7 @@ static void print_joined(const char *singular, const char *plural,
>  }
>  
>  static void shortlog(const char *name, unsigned char *sha1,
> -		struct commit *head, struct rev_info *rev, int limit,
> +		struct commit *head, struct rev_info *rev,
>  		struct strbuf *out)

A part of me wishes we would still pass the limit around (for no good
reason), but you are probably right that it is easier to work with the
global.

> @@ -257,7 +264,7 @@ static void do_fmt_merge_msg_title(struct strbuf *out,
> 
>  static int do_fmt_merge_msg(int merge_title, int merge_summary,

What happened to the merge_summary argument?
