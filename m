From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff across submodules
Date: Wed, 19 Sep 2012 15:31:14 -0700
Message-ID: <7v4nmtfxvx.fsf@alter.siamese.dyndns.org>
References: <1347937959.96154.YahooMailClassic@web39403.mail.mud.yahoo.com>
 <5058C53B.5040401@web.de> <7vobl3m8pb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 00:31:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TESno-0000LW-6Z
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 00:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440Ab2ISWbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 18:31:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072Ab2ISWbR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 18:31:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA3BF8AFF;
	Wed, 19 Sep 2012 18:31:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qjafZXWgJhskzrKvbYRDqHQ9YIk=; b=dfkDBR
	LydyIbozEURbGgNMUt8OypB2TT5rpP/I36QbcNNSYpX4YTShlJbNC7uUWxki/Wbp
	0QwEyM5XohoA9CLa1T1gaDnqsUXMLW4JTgx4HIxDOnZU/dQDGhH04hUu7nGpDP4J
	tgAVdf+VGN2EjDmvNIxXODLYHXqgOE3tAlmzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JssEkz9lisVePhNM6OdpAKVzUbv6eWmI
	hXq/mhF6YLLlWqOCrDy7YQIZPNzVy27GRPfdqKByoGzu/jb3nRfyVWGKI8IrGfL8
	Tq3QEFHWrQX9JntGf5zBiXubb3P38csH+dfYkd23Rd6Z/SE83Hn/KvmQWVmJfFus
	qgiYs9l6qa4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6A3A8AFE;
	Wed, 19 Sep 2012 18:31:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B9A18AFD; Wed, 19 Sep 2012
 18:31:16 -0400 (EDT)
In-Reply-To: <7vobl3m8pb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 18 Sep 2012 12:28:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B99B2B04-02A9-11E2-9559-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206005>

Junio C Hamano <gitster@pobox.com> writes:

> I also suspect that you do not have to change "git diff" at all to
> show the patch recursively by using the attribute mechanism (look in
> Documentation/gitattributes.text for a string GIT_EXTERNAL_DIFF).
> It might be just as simple as doing this:
>
> 	echo >.gitattributes "/lib/frotz diff=subrecurse" 
> 	git config diff.subrecurse.command $HOME/bin/diff-subrecurse
>       cat >$HOME/bin/diff-subrecurse <<\-EOF
> 	#!/bin/sh
>       path=$1 old_hex=$3 new_hex=$6
>       unset GIT_DIR
>       cd "$path" || exit 1
>       git diff "$old_hex" "$new_hex"        
>       EOF
>       chmod +x $HOME/bin/diff-subrecurse
>
> The corner cases like "new submodule", "removed submodule" are left
> as an exercise to the reader ;-)

It turns out that essentially the above outline I concocted in my
MUA is usable almost as-is.

Here is what I ended up with.

 * In .git/config of the superproject, I added this:

        [diff "submodule-recurse"]
		command = src/bin/diff-submodule-recurse

 * In the superproject, src/bin/diff-submodule-recurse has this
   (this is probably whitespace damaged---the lines must be indented
   by HT for the here document to correctly work):

        #!/bin/sh
        # $1   $2       $3      $4       $5       $6      $7
        # path old-file old-hex old-mode new-file new-hex new-mode

        case "$#,$4,$7" in
        7,160000,160000) ;;
        *)      echo "diff --git a/$1 b/$1"
                echo "(punt)"
                exit
                ;;
        esac
        unset GIT_DIR
        cd "$1" || {
                cat <<-\EOF
                diff --git a/$1 b/$1
                (cannot chdir to $1)
		-Subproject commit $3
		+Subproject commit $6
                EOF
        }
        git --no-pager diff --src-prefix="s/$1/" --dst-prefix="m/$1/" "$3" "$6"

 * In .gitattributes of the superproject, I have this:

        /var	diff=submodule-recurse

The superproject in this case is a repository to control what I have
in my $HOME directory (e.g. it has src/dot/Makefile that builds and
installs the appropriate dotfiles, src/bin/Makefile that builds and
installs to $HOME/bin, etc.), and one subdirectory, 'var', is a
submodule that is only cloned to some but not all machines I clone
this superproject to.

With this setting, things like

	$ git diff HEAD~20

show differences with recursion into the var/ submodule just fine.
