From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/14] pull: implement fetch + merge
Date: Mon, 18 May 2015 17:55:57 +0200
Organization: gmx
Message-ID: <8fdf250d93dc34505fc77f01b415a43b@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
 <1431961571-20370-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 17:56:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuNOn-0004op-6C
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbbERP4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:56:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:50737 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932199AbbERP4B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:56:01 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LnfuZ-1ZNwif0OY3-00hufg; Mon, 18 May 2015 17:55:58
 +0200
In-Reply-To: <1431961571-20370-2-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:5hyyJN8lJ2nAZkHgylBENCem6GWuUwm7ZNwQqRIW+aNYijzAQpj
 nzK7GSbyLRfQ49eIqrw2Gh1nDWUTCWAYpz3Cl3LKXHy5RxGL/mwe2xhy/SM7haZ5TozV/eL
 8BYXR2+UklJ0TuuLmkN+C9hELt4C6lBgKKKFTzDakS3q5X+j0h9yxkg2fFIY08Y4ikIo+cU
 eLqjIe7jZbhRE5/PsGekw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269280>

Hi Paul,

On 2015-05-18 17:05, Paul Tan wrote:
> Start off the rewrite of git-pull.sh to C by implementing a simple
> git-pull builtin that:
> 
> 1. Parses the command line arguments into [<repo> [<refspecs>...]]
> 
> 2. Runs git-fetch, passing the repo and refspecs to it.
> 
> 3. Runs git-merge FETCH_HEAD.
> 
> Due to missing features, several tests are disabled:
> 
> * Passing flags to git fetch, rebase, merge:
> 
>   * t5521: verbosity flags -v, -s
> 
> * Passing flags to git-merge, git-rebase:
> 
>   * t5150, t5572: Pass --ff, --no-ff, --ff-only to git-merge
> 
>   * t5520, t5521, t7406: Support --rebase, branch.*.rebase and
>     pull.rebase config
> 
>   * t6029, t4013: -s/--strategy
> 
>   * t6037: -X/--strategy-option
> 
>   * t5524: --log
> 
> * Passing flags to git-fetch:
> 
>   * t5521: --dry-run
> 
>   * t5500: --depth
> 
>   * t5521: --force
> 
>   * t5521: --all
> 
>   * t7403: --no-recurse-submodules
> 
> * t7601: pull.ff config sets --ff, --no-ff, --ff-only
> 
> * t5520: branch.*.rebase or pull.rebase sets --rebase, --rebase=preserve
> 
> * t5520: Pulling into void
> 
> * t5520: appropriate user-friendly error messages on no merge candidates
>   case
> 
> * t5520: appropriate user-friendly error messages if index has
>   unresolved entries.
> 
> * t5520: fast-forward working tree if branch head is updated by
>   git-fetch
> 
> * t5520: set reflog action to "pull args..."
> 
> These features will be re-implemented in succeeding patches.
> 
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  Makefile                     |   2 +-
>  builtin.h                    |   1 +
>  builtin/pull.c               |  83 +++++++++++
>  contrib/examples/git-pull.sh | 339 +++++++++++++++++++++++++++++++++++++++++++
>  git-pull.sh                  | 339 -------------------------------------------
>  git.c                        |   1 +
>  t/t4013-diff-various.sh      |   3 +
>  t/t5150-request-pull.sh      |   2 +-
>  t/t5500-fetch-pack.sh        |  10 +-
>  t/t5520-pull.sh              |  68 ++++-----
>  t/t5521-pull-options.sh      |  20 +--
>  t/t5524-pull-msg.sh          |   2 +-
>  t/t5572-pull-submodule.sh    |   4 +
>  t/t6029-merge-subtree.sh     |   6 +-
>  t/t6037-merge-ours-theirs.sh |   2 +-
>  t/t7403-submodule-sync.sh    |   8 +-
>  t/t7406-submodule-update.sh  |   2 +
>  t/t7601-merge-pull-config.sh |   4 +-

This is an excellent way to develop the patch series. For the final patch series, I would like to propose that `git-pull.sh` is replaced by the builtin with the very last patch, though. That way, the builtin can be implemented in the way you did, but without touching the tests. In the final form, the builtin git-pull will be a drop-in replacement for the shell script, and the final patch will just make that switch.

In other words, patch 1/N would leave SCRIPT_SH in the Makefile untouched, and leave out the "pull" line from `git.c`.

Oh, by the way, if you pass the `-M` option to `git format-patch`, the diffstat will report the move rather than an added and a deleted git-pull.sh.

Ciao,
Dscho
