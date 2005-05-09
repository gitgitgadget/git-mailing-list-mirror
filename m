From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-log patches
Date: Mon, 9 May 2005 14:14:35 +0200
Message-ID: <20050509121435.GB18382@pasky.ji.cz>
References: <1742.10.10.10.24.1115573750.squirrel@linux1> <20050508234936.GA26624@diku.dk> <4302.10.10.10.24.1115610350.squirrel@linux1> <20050509113907.GA22830@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 14:09:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV73o-0001sF-Kc
	for gcvg-git@gmane.org; Mon, 09 May 2005 14:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVEIMPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 08:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVEIMPQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 08:15:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7296 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261311AbVEIMOh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 08:14:37 -0400
Received: (qmail 22993 invoked by uid 2001); 9 May 2005 12:14:35 -0000
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20050509113907.GA22830@diku.dk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 01:39:07PM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> Fix cg-log -f option so that a complete list of files is
> displayed when a commit has more than one parent.
> 
> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

But that makes no sense, since each merge will have enormous amount of
files listed, making no sense. E.g. each merge of Cogito with Linus will
have all the Cogito files listed, since they aren't in the Linus branch
- but that's wrong, since the merge _to_ the Cogito branch concerns no
Cogito files.

In git, the parents list is unordered. But this is different in Cogito,
where the first parent _is_ special. If you are merging _from_ branch B
_to_ branch A, the order of parents will be always

parent A
parent B

In practice, it does not make too much difference, but this is one of
the cases where it makes difference. So I think the current behaviour is
right.

BTW, this also implies that merges

  A --
      \
  B ---+--

and

  A ---+--
      /
  B --

are considered as different ones by Cogito; in git itself, you might
model that as

  A --.
       >---
  B --'

which is not possible in Cogito. I could imagine doing it by e.g.
passing cg-clone multiple arguments, but I'd have to first see a
compelling real-world usage for this first.

> Index: cg-log
> ===================================================================
> --- 95bc73fd188347aa294991d1c5c7cffd60422098/cg-log  (mode:100755)
> +++ ddf82a0140bdc1440eb93bcbe01e14e90e44a3e8/cg-log  (mode:100755)
> @@ -67,8 +67,16 @@
>  		done
>  	fi | sort -u | \
>  	while read modes type sha1s file; do
> -		echo -n "$sep$file"
> +		echo -n "$sep"
>  		sep=", "
> + 		if [ $(echo "$line$sep$file" | wc -c) -lt 75 ]; then
> + 			line="$line$sep$file"
> + 			echo -n "$file"
> + 		else
> + 			line="$file"
> + 			echo "$coldefault"
> + 			echo -n "    $colfiles$file"
> + 		fi
>  	done
>  	echo "$coldefault:"
>  }

Could we have a trailing comma at the previous line?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
