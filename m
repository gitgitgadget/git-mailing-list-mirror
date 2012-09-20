From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git diff across submodules
Date: Thu, 20 Sep 2012 21:51:42 +0200
Message-ID: <505B73CE.5030009@web.de>
References: <1347937959.96154.YahooMailClassic@web39403.mail.mud.yahoo.com> <5058C53B.5040401@web.de> <7vobl3m8pb.fsf@alter.siamese.dyndns.org> <7v4nmtfxvx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:52:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmn4-0004L2-SU
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab2ITTvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:51:51 -0400
Received: from mout.web.de ([212.227.17.12]:55962 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754654Ab2ITTvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:51:50 -0400
Received: from [192.168.178.41] ([91.3.187.46]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0Lb29N-1TuQ0b3EhV-00kSGI; Thu, 20 Sep 2012 21:51:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7v4nmtfxvx.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:ybYYUiFDo5BNNPKAO/9UCCiuQ/qA03blN8WOIpHniL9
 TuKD9zKGm8PWCki4b55iuisTXkKXgIy1QwcePnpD2CbVf/h5Fn
 jOGFEDxtgMuzJMmA+Intr/34T/YUXqhD3/dB047krktaFusLBt
 mC3NbKep9QVzfElDdx4CcydFRlOzTyZThI5eSKZSEJIQz/UzuI
 l3sUQYi2ajjGm5Juhsi2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206087>

Am 20.09.2012 00:31, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I also suspect that you do not have to change "git diff" at all to
>> show the patch recursively by using the attribute mechanism (look in
>> Documentation/gitattributes.text for a string GIT_EXTERNAL_DIFF).
>> It might be just as simple as doing this:
>>
>> 	echo >.gitattributes "/lib/frotz diff=subrecurse" 
>> 	git config diff.subrecurse.command $HOME/bin/diff-subrecurse
>>       cat >$HOME/bin/diff-subrecurse <<\-EOF
>> 	#!/bin/sh
>>       path=$1 old_hex=$3 new_hex=$6
>>       unset GIT_DIR
>>       cd "$path" || exit 1
>>       git diff "$old_hex" "$new_hex"        
>>       EOF
>>       chmod +x $HOME/bin/diff-subrecurse
>>
>> The corner cases like "new submodule", "removed submodule" are left
>> as an exercise to the reader ;-)
> 
> It turns out that essentially the above outline I concocted in my
> MUA is usable almost as-is.
> 
> Here is what I ended up with.
> 
>  * In .git/config of the superproject, I added this:
> 
>         [diff "submodule-recurse"]
> 		command = src/bin/diff-submodule-recurse
> 
>  * In the superproject, src/bin/diff-submodule-recurse has this
>    (this is probably whitespace damaged---the lines must be indented
>    by HT for the here document to correctly work):
> 
>         #!/bin/sh
>         # $1   $2       $3      $4       $5       $6      $7
>         # path old-file old-hex old-mode new-file new-hex new-mode
> 
>         case "$#,$4,$7" in
>         7,160000,160000) ;;
>         *)      echo "diff --git a/$1 b/$1"
>                 echo "(punt)"
>                 exit
>                 ;;
>         esac
>         unset GIT_DIR
>         cd "$1" || {
>                 cat <<-\EOF
>                 diff --git a/$1 b/$1
>                 (cannot chdir to $1)
> 		-Subproject commit $3
> 		+Subproject commit $6
>                 EOF
>         }
>         git --no-pager diff --src-prefix="s/$1/" --dst-prefix="m/$1/" "$3" "$6"
> 
>  * In .gitattributes of the superproject, I have this:
> 
>         /var	diff=submodule-recurse
> 
> The superproject in this case is a repository to control what I have
> in my $HOME directory (e.g. it has src/dot/Makefile that builds and
> installs the appropriate dotfiles, src/bin/Makefile that builds and
> installs to $HOME/bin, etc.), and one subdirectory, 'var', is a
> submodule that is only cloned to some but not all machines I clone
> this superproject to.
> 
> With this setting, things like
> 
> 	$ git diff HEAD~20
> 
> show differences with recursion into the var/ submodule just fine.

That's pretty cool! Even though diff options like --stat and --name-only
still won't take into account what happened inside the submodule this
approach makes it possible to see the diff recursively. Wouldn't it make
sense add this script to contrib (after teaching it new and removed
submodules and documenting its use in a few lines after the shebang)?
