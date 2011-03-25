From: "igor.mikushkin" <igor.mikushkin@gmail.com>
Subject: Re: Why git silently replaces untracked files?
Date: Fri, 25 Mar 2011 10:53:48 -0700 (PDT)
Message-ID: <1301075628970-6208585.post@n2.nabble.com>
References: <1301064754576-6207950.post@n2.nabble.com> <20110325165811.GB25851@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 18:53:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3BCs-0003y9-1G
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 18:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab1CYRxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 13:53:49 -0400
Received: from sam.nabble.com ([216.139.236.26]:40019 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525Ab1CYRxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 13:53:49 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <igor.mikushkin@gmail.com>)
	id 1Q3BCm-0005Nd-VU
	for git@vger.kernel.org; Fri, 25 Mar 2011 10:53:48 -0700
In-Reply-To: <20110325165811.GB25851@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170004>


Jeff King wrote:
> 
> On Fri, Mar 25, 2011 at 07:52:34AM -0700, igor.mikushkin wrote:
> 
> &gt; Why git silently replaces untracked files?
> &gt; 
> &gt; # mkdir test.git
> &gt; # mkdir 1
> &gt; # mkdir 2
> &gt; # echo 1 &gt; 1/test
> &gt; # echo 2 &gt; 2/test
> &gt; # cd test.git
> &gt; # git init --bare
> &gt; # cd ..
> &gt; # git clone test.git
> &gt; # cp -r test/.git 1
> &gt; # cp -r test/.git 2
> &gt; # cd 1
> &gt; # git add test
> &gt; # git commit -am 1
> &gt; # git push origin master
> &gt; # cd ../2
> &gt; # git pull
> &gt; # cat test
> &gt; 1
> &gt; 
> &gt; In my opinion it is wrong behavior.
> &gt; I've just lost important file due to it.
> &gt; 
> &gt; Should not &quot;git pull&quot; fail here?
> 
> Ick, definitely it's wrong behavior. The culprit seems to be a special
> code path for the initial pull which doesn't merge at all, but calls
> read-tree --reset. It should probably be:
> 
> diff --git a/git-pull.sh b/git-pull.sh
> index a3159c3..fb9e2df 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -253,7 +253,7 @@ esac
>  if test -z &quot;$orig_head&quot;
>  then
>  	git update-ref -m &quot;initial pull&quot; HEAD $merge_head
> &quot;$curr_head&quot; &amp;&amp;
> -	git read-tree --reset -u HEAD || exit 1
> +	git read-tree -m -u HEAD || exit 1
>  	exit
>  fi
> 
> Though I don't know if there are any cases where the --reset would be
> beneficial over &quot;-m&quot;. I couldn't think of any.
> 

Thanks Jeff,
My opinion is that you are right and merging is best here
(Though just fail would be probably OK either).
Love one line fixes.

Igor

--
View this message in context: http://git.661346.n2.nabble.com/Why-git-silently-replaces-untracked-files-tp6207950p6208585.html
Sent from the git mailing list archive at Nabble.com.
