From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: index manipulation -- how?
Date: Mon, 21 Nov 2005 22:20:47 -0800 (PST)
Message-ID: <20051122062048.8891.qmail@web31805.mail.mud.yahoo.com>
References: <7v3blpi6r7.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 07:30:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeRWj-0003nh-IY
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 07:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVKVGUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 01:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVKVGUt
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 01:20:49 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:63639 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750887AbVKVGUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 01:20:48 -0500
Received: (qmail 8893 invoked by uid 60001); 22 Nov 2005 06:20:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=m8xozABb2UddmYqwzvUP+h6oyTZo6dF4UKVl4BFNvPQYeJu3T4rfDGqmfjHzlpdLghGpUyQ9iPIDGXVf1Hq55RhqvWsevLAx0OeN5jfHlNBIeNjczffK+rJFouskCEKzL3QqAVR4bcNw8CE9TH0i0Hcabxetmp+mfb9vt0r8Gl0=  ;
Received: from [68.221.119.157] by web31805.mail.mud.yahoo.com via HTTP; Mon, 21 Nov 2005 22:20:47 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3blpi6r7.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12530>

--- Junio C Hamano <junkio@cox.net> wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> >
> >> How do I reverse a _single_ "git-update-index" operation?
> >> Be it --add or just an update.
> >
> > Reverting working tree files are "git checkout HEAD the-file"
> > (both index and working tree file from the head commit) or "git
> > checkout -- the-file" (working tree file from the index), but I
> > do not think there is a prepackaged way to revert only a single
> > index path offhand.
> >
> >         git-ls-tree HEAD the-file |
> >         sed -e 's/^\([0-7]*\) [^ ]* \(.*\)/\1 \2/' |
> >         git-update-index --index-info

Ok.
(There is a very similar construct in git-checkout.sh.
So if you apply the patch below, please make sure
git-checkout.sh doesn't break.)

Question: so in effect, more generally:
  git checkout <tree-ish> <file>

would do the right thing: update index and the working
tree as the file <file> looked as it was at <tree-ish>?

Is that correct?  Can someone confirm/deny?

   Luben
P.S. So both methods as mentioned by Linus and Junio
do what I asked about.

> >
> > should work.
> >
> > I think changing update-index --index-info so that you can lose
> > the sed in between without breaking its other usage (it reads
> > from git-apply --index-info, which does not say " blob " which
> > is what the sed is stripping out) is a worthwhile thing to do.
> 
> And here is the patch to let you say:
> 
> 	git-ls-tree HEAD the-file | git-update-index --index-info
> 
> 
> ---
> 
> diff --git a/update-index.c b/update-index.c
> index 5bbc3de..11b7f6a 100644
> --- a/update-index.c
> +++ b/update-index.c
> @@ -338,7 +338,7 @@ static void read_index_info(int line_ter
>  	struct strbuf buf;
>  	strbuf_init(&buf);
>  	while (1) {
> -		char *ptr;
> +		char *ptr, *tab;
>  		char *path_name;
>  		unsigned char sha1[20];
>  		unsigned int mode;
> @@ -348,12 +348,15 @@ static void read_index_info(int line_ter
>  			break;
>  
>  		mode = strtoul(buf.buf, &ptr, 8);
> -		if (ptr == buf.buf || *ptr != ' ' ||
> -		    get_sha1_hex(ptr + 1, sha1) ||
> -		    ptr[41] != '\t')
> +		if (ptr == buf.buf || *ptr != ' ')
>  			goto bad_line;
>  
> -		ptr += 42;
> +		tab = strchr(ptr, '\t');
> +		if (!tab || tab - ptr < 41)
> +			goto bad_line;
> +		if (get_sha1_hex(tab - 40, sha1) || tab[-41] != ' ')
> +			goto bad_line;
> +		ptr = tab + 1;
>  
>  		if (line_termination && ptr[0] == '"')
>  			path_name = unquote_c_style(ptr, NULL);
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
