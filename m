From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] test: some testcases failed if cwd is on a symlink
Date: Sat, 18 Aug 2012 14:41:11 +0000 (UTC)
Message-ID: <loom.20120818T162226-852@post.gmane.org>
References: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com> <7vboj5gqqo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 18 16:45:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2kHE-00062M-RO
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 16:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab2HROpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 10:45:13 -0400
Received: from plane.gmane.org ([80.91.229.3]:48335 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538Ab2HROpL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 10:45:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1T2kGu-0005d6-6R
	for git@vger.kernel.org; Sat, 18 Aug 2012 16:45:04 +0200
Received: from p57A25507.dip.t-dialin.net ([87.162.85.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Aug 2012 16:45:04 +0200
Received: from mhagger by p57A25507.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Aug 2012 16:45:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.162.85.7 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.19 (KHTML, like Gecko) Ubuntu/12.04 Chromium/18.0.1025.168 Chrome/18.0.1025.168 Safari/535.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203674>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Jiang Xin <worldhello.net <at> gmail.com> writes:
> 
> > Run command 'git rev-parse --git-dir' under subdir will return realpath
> > of '.git' directory. Some test scripts compare this realpath against
> > "$TRASH_DIRECTORY", they are not equal if current working directory is
> > on a symlink.
> >
> > In this fix, get realpath of "$TRASH_DIRECTORY", store it in
> > "$TRASH_REALPATH" variable, and use it when necessary.
> 
> I wonder if running test in a real directory (in other words, "fix"
> your cwd) may be a simpler, more robust and generally a better
> solution, e.g. something silly like...
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index acda33d..7f6fb0a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -15,6 +15,8 @@
>  # You should have received a copy of the GNU General Public License
>  # along with this program.  If not, see http://www.gnu.org/licenses/ .
> 
> +cd "$(pwd -P)"
> +
>  # if --tee was passed, write the output not only to the terminal, but
>  # additionally to the file test-results/$BASENAME.out, too.
>  case "$GIT_TEST_TEE_STARTED, $* " in

What is the status of this bug?  Today I wasted a bunch of time trying to track 
down a build breakage that was ultimately caused by this problem.  I was running 
the test suite on master with "--root=/dev/shm" (my usual setting), but this 
caused tests t4035 and t9903 to fail as described upthread.  (It turns out that 
on my system, /dev/shm is a symlink to /run/shm.)

For me, the failure is fixed by Jiang Xin's patch, but it is not fixed by 
Junio's.  In the case of t4035 in failing test "git diff --ignore-all-space, 
both files outside repo", right before "git diff" is called,

PWD=/run/shm/trash directory.t4035-diff-quiet/test-outside/non/git
GIT_CEILING_DIRECTORIES=/dev/shm/trash directory.t4035-diff-quiet/test-outside

I can work around the problem by using "--root=/run/shm".  But it would be good 
to get this problem fixed one way or the other to spare other people the same 
pain.

Michael
