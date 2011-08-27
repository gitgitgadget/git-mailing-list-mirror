From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: [PATCH] checkout: be quiet if not on isatty()
Date: Sat, 27 Aug 2011 21:45:51 +0200
Message-ID: <cover.1314472512.git.sdaoden@gmail.com>
References: <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
Cc: Steffen Daode Nurpmeso <sdaoden@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 21:47:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxOqO-0006fl-D5
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 21:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab1H0Tq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 15:46:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55066 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab1H0Tq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 15:46:57 -0400
Received: by fxh19 with SMTP id 19so3376857fxh.19
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to;
        bh=AfyReiyD2B0z52X8LRJPTvWeO2GiNi/egTQmxUSwNqA=;
        b=kj0FW7lGGTJfBpCJtoDhOOifBp5t1AfK+kyM6svTiI0SykrwO+1Kcq+Rmp3fxACjs1
         fXiYY6f4nBWDJJCiZHJF21/CdBm8O+4lZFBauOfyQUv1wdxLHJj9d57qAO/zsPvBOXXN
         q2tWTRWuUXfYrkrZpBSHz+FcAd6pNWCf6V5CA=
Received: by 10.223.44.89 with SMTP id z25mr9236fae.28.1314474415735;
        Sat, 27 Aug 2011 12:46:55 -0700 (PDT)
Received: from localhost.localdomain ([89.204.137.195])
        by mx.google.com with ESMTPS id 16sm2372802faw.42.2011.08.27.12.46.52
        (version=SSLv3 cipher=OTHER);
        Sat, 27 Aug 2011 12:46:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.537.ga80e5.dirty
In-Reply-To: <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180243>

(Original subject was:
Re: [PATCH] progress: use \r as EOL only if isatty(stderr) is true)

@ Junio C Hamano <gitster@pobox.com> wrote (2011-06-28 20:33+0200):
> [..]
> I thought that we try to disable the progress pretty much
> everywhere when we are not talking to a tty[..]

Today i got this by accident:

    ================================================================
    openbsd-src.git-null: performing reduce
    Checking out files:  17% (11410/65508)   ^MChecking out files:
    18% (11792/65508)   ^M [..]

This is the output of my dumb arena-manager, which i append after
the first scissor for reference.  (Maybe someone finds it useful.
It's a dumb sh(1) thing, i don't do shell scripting that often.)
I haven't actually tried it yet, but setting .quiet for
unpack_trees may stop this output.  (Compilation succeeds,
though.)  I still and *truly* have no idea of the git(1)
internals, so i may oversee .. just *any* thinkable side-effect.
Hope this helps a bit.
(Actual patch as response.  Have a nice weekend.)

--Steffen
Ciao, sdaoden(*)(gmail.com)
ASCII ribbon campaign           ( ) More nuclear fission plants
  against HTML e-mail            X    can serve more coloured
    and proprietary attachments / \     and sounding animations
-- >8 --
#!/bin/bash
# NOTE: this acts according to extensions, e.g.:
#   docutils.svn-git-null: git svn
#   groff.cvs-git-null   : git cvsimport
#   openbsd-src.git-null : git
#   vim.hg-null          : Mercurial
# If a '-null' is in the suffix one may use 'reduce' and 'expand'
# modes; for git(1) these modes require an empty NULL branch:
#   $ git co --orphan NULL && git rm -rf '*' &&
#     echo DEFAULT-BRANCH >NULL && git add NULL && git ci -m NULL
# Mercurial has builtin support for 'null'.  (Nice for backups.)

# Top dir where everything happens
ARENA="$HOME/arena/code.extern.repos"

##

GIT=git
HG=hg
SVN=svn
CVS='cvs -fz 9 update -ACRPd'
ESTAT=0
LOGFILE=lastlog.txt
CVSROOT=/nonexistent
CURR=/nonexistent

log() {
    echo "$*"
    echo "$*" >> $LOGFILE
}
logerr() {
    echo >&2 "ERROR: $*"
    echo "ERROR: $*" >> $LOGFILE
    ESTAT=1
}

SEP='================================================================'
intro() {
    log ''
    log $SEP
    log $1
}
final() {
    local es=$?
    if test $es -eq 0; then
        log "... ok: $1"
    else
        logerr "$1"
        ESTAT=$es
    fi
    log $SEP
    log ''
}

if test "$BASH" = x""; then
    echo >&2 "This script needs the GNU bash shell interpreter"
    exit 1
fi
cd $ARENA || {
    echo >&2 "Failed to chdir to $ARENA"
    exit 1
}
rm -rf $LOGFILE || {
    echo >&2 "Failed to remove stale $LOGFILE"
    exit 1
}

MODE="$1"
shift
PARAMS="$@"
set -u
test $# -ne 0 || PARAMS=$(echo *.*)

# Perform basename cleanup and move over to $params[]
log "$0: script startup, mode $MODE"
declare -a params
for rd in $PARAMS; do
    rd=$(echo "$rd" | sed -Ee 's/(.+)\/+$/\1/' -e 's/.*\/([^/]+)$/\1/')
    params[${#params[*]}]="$rd"
done

GITDID=
case "$MODE" in
reduce|expand)
    if test "$MODE" == 'reduce'; then
        git_branch='NULL'
        hg_branch='null'
    else
        git_branch=
        hg_branch=''
    fi

    for rd in ${params[@]}; do
        if test "$rd" == "${rd/null/}"; then
            log "[$rd: $MODE does not apply]"
            continue
        fi

        intro "$rd: performing $MODE"
        set -o pipefail
        (   cd "$rd" || exit 1
            if test "$rd" != "${rd/git-null}"; then
                # On branch NULL file NULL contains master branch's name
                if test -z "$git_branch"; then
                    if test -f NULL; then
                        git_branch=$(<NULL)
                    else
                        echo >&2 "No file NULL in $rd"
                        git_branch=master
                    fi
                fi
                $GIT checkout $git_branch
            else
                $HG up $hg_branch
            fi
            exit $?
        ) 2>&1 | tee -a "$LOGFILE"
        final "$rd"
        set +o pipefail
    done
    ;;
update)
    for rd in ${params[@]}; do
        intro "$rd: performing $MODE"
        set -o pipefail
        (   cd "$rd" || exit 1
            if test "$rd" != "${rd/.git}"; then
                #$GIT pull -v --ff-only --stat --prune
                $GIT fetch --verbose --prune
                GITDID=1
            elif test "$rd" != "${rd/.svn-git}"; then
                $GIT svn rebase
                GITDID=1
            elif test "$rd" != "${rd/.cvs-git}"; then
                ldir='.git/.cvsps'
                tar xjf "$ldir.tbz" || {
                    echo >&2 "$rd: bail: tar xjf $ldir.tbz"
                    exit 1
                }
                hdir="$HOME/.cvsps"
                test -d "$hdir" || mkdir "$hdir" || {
                    echo >&2 "$rd: failed to create $hdir directory"
                    exit 2
                }
                root="$ldir/CVSROOT"
                repo="$ldir/MODULE"
                cache=$(<$ldir/CVSPS_FILE)
                mv -f "$ldir/cvs-revisions" .git/
                mv -f "$ldir/$cache" "$hdir/$cache"
                $GIT cvsimport -aR -r origin -p '-u,--cvs-direct' \
                     -d $(<$root) $(<$repo)
                es=$?
                GITDID=1
                mv -f .git/cvs-revisions "$ldir/"
                mv -f "$hdir/$cache" "$ldir/$cache"
                tar cjf "$ldir.tbz" "$ldir" || {
                    echo >&2 "$rd: bail: tar cjf $ldir.tbz $ldir"
                    exit 3
                }
                rm -rf $ldir
                exit $es
            elif test "$rd" != "${rd/.hg}"; then
                $HG -v pull #-u
            elif test "$rd" != "${rd/.svn}"; then
                $SVN update
            elif test "$rd" != "${rd/.cvs}"; then
                $CVS
            else
                echo "Unknown revision-control-system: $rd"
                exit 1
            fi
        ) 2>&1 | tee -a "$LOGFILE"
        final "$rd"
        set +o pipefail
    done
    ;;
fullgc|gc)
    gct=
    test "$MODE" == fullgc && gct=--aggressive
    for rd in ${params[@]}; do
        intro "$rd: performing $MODE"
        set -o pipefail
        (   cd "$rd" || exit 1
            test "$rd" != "${rd/.git}" && git gc $gct
        ) 2>&1 | tee -a "$LOGFILE"
        final "$rd"
        set +o pipefail
    done
    ;;
*)
    echo 'USAGE: manager reduce|expand|update|gc|fullgc LIST-OF-DIRECTORIES'
    exit 1
    ;;
esac
test x"$GITDID" != x && log 'git(1) fetched data - do arena-manager [full]gc ..'

test $ESTAT -ne 0 && log 'Errors occurred!'
exit $ESTAT
# vim:set fenc=utf-8 filetype=sh syntax=sh ts=4 sts=4 sw=4 et tw=79:
