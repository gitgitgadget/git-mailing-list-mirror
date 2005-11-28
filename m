From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: lost again on syntax change - local repository?
Date: 28 Nov 2005 11:25:06 -0800
Message-ID: <86psok378t.fsf@blue.stonehenge.com>
References: <861x118r9t.fsf@blue.stonehenge.com>
	<20051128104831.GN22159@pasky.or.cz>
	<86d5kk7wbv.fsf@blue.stonehenge.com>
	<20051128134111.GP22159@pasky.or.cz>
	<86zmno6g3v.fsf@blue.stonehenge.com>
	<20051128143428.GS22159@pasky.or.cz>
	<868xv86dam.fsf@blue.stonehenge.com>
	<20051128191546.GT22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 20:25:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egocn-0001RM-G2
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 20:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVK1TZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 14:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVK1TZK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 14:25:10 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:49198 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932192AbVK1TZI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 14:25:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 8F2448F6FE;
	Mon, 28 Nov 2005 11:25:07 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 01614-01-10; Mon, 28 Nov 2005 11:25:06 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E3A3D8F6FF; Mon, 28 Nov 2005 11:25:06 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
x-mayan-date: Long count = 12.19.12.15.0; tzolkin = 11 Ahau; haab = 18 Ceh
In-Reply-To: <20051128191546.GT22159@pasky.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12899>

>>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:

Petr> Could you try the following, please?

Petr> diff --git a/cg-push b/cg-push
Petr> index 1d59422..323ef26 100755
Petr> --- a/cg-push
Petr> +++ b/cg-push
Petr> @@ -56,13 +56,13 @@ if echo "$uri" | grep -q '#'; then
Petr>  	uri=$(echo $uri | cut -d '#' -f 1)
Petr>  fi
 
Petr> -if echo "$uri" | grep -q "^http://"; then
Petr> +if [ "${uri#http://}" != "$uri" ]; then
Petr>  	die "pushing over HTTP not supported yet"
Petr> -elif echo "$uri" | grep -q "^git+ssh://"; then
Petr> +elif [ "${uri#git+ssh://}" != "$uri" ]; then
Petr>  	send_pack_update "$name" "$(echo "$uri" | sed 's#^git+ssh://\([^/]*\)\(/.*\)$#\1:\2#')" $_git_head$sprembranch "${tags[@]}"
Petr> -elif echo "$uri" | grep -q "^rsync://"; then
Petr> +elif [ "${uri#rsync://}" != "$uri" ]; then
Petr>          die "pushing over rsync not supported"
Petr> -elif echo "$uri" | grep -q ":"; then
Petr> +elif [ "${uri#*:}" != "$uri" ]; then
Petr>  	echo "WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol."
Petr>  	echo "WARNING: The host:path syntax is evil because it is implicit. Please just use a URI."
Petr>  	send_pack_update "$name" "$uri" $_git_head$sprembranch "${tags[@]}"

Bizarrely, same behavior.  Mark me "puzzled".

    localhost:~/Projects/Git/Play % cg-admin-setuprepo remote.git        
    localhost:~/Projects/Git/Play % mkdir local.git
    localhost:~/Projects/Git/Play % cd local.git 
    localhost:..Git/Play/local.git % cg-init -mempty
    defaulting to local storage area
    Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
    Committed as ee28097d96063ae660faf325f5bffdbcbc6818f4.
    localhost:..Git/Play/local.git % cg-branch-add origin "$(cd ..; pwd)/remote.git#master"           
    localhost:..Git/Play/local.git % cg-branch-ls   
    origin  /Users/merlyn/Projects/Git/Play/remote.git#master
    localhost:..Git/Play/local.git % cg-push
    WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol.
    WARNING: The host:path syntax is evil because it is implicit. Please just use a URI.
    ssh: \033]2;[zsh] localhost: No address associated with nodename
    fatal: unexpected EOF
    localhost:..Git/Play/local.git % which cg-push
    /opt/git/bin/cg-push
    localhost:..Git/Play/local.git % grep uri $(which cg-push)
    uri=$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch: $name"
    if echo "$uri" | grep -q '#'; then
            rembranch=$(echo $uri | cut -d '#' -f 2)
            uri=$(echo $uri | cut -d '#' -f 1)
    if [ "${uri#http://}" != "$uri" ]; then
    elif [ "${uri#git+ssh://}" != "$uri" ]; then
            send_pack_update "$name" "$(echo "$uri" | sed 's#^git+ssh://\([^/]*\)\(/.*\)$#\1:\2#')" $_git_head$sprembranch "${tags[@]}"
    elif [ "${uri#rsync://}" != "$uri" ]; then
    elif [ "${uri#*:}" != "$uri" ]; then
            send_pack_update "$name" "$uri" $_git_head$sprembranch "${tags[@]}"
            remgit="$uri"; [ -d "$remgit/.git" ] && remgit="$remgit/.git"
                    send_pack_update "$name" "$uri" $_git_head$sprembranch "${tags[@]}"


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
