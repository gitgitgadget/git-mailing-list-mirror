From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Breakage in master since 6d4bb3833c
Date: Sat, 22 Oct 2011 07:11:20 +0200
Message-ID: <4EA25078.8060501@alum.mit.edu>
References: <4EA1614D.3090202@alum.mit.edu> <20111021122801.GA3799@goldbirke> <4EA17B1D.9000900@alum.mit.edu> <7vehy68ejp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 22 07:11:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHTrr-0006jU-MY
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 07:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615Ab1JVFLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 01:11:31 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54553 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1JVFLa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 01:11:30 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEA728.dip.t-dialin.net [84.190.167.40])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9M5BLYa006548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 22 Oct 2011 07:11:21 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vehy68ejp.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184097>

On 10/21/2011 07:01 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Yes, you are right.  Setting GIT=$(pwd)/bin-wrappers/git fixes the problem.
> 
> So in short, this was a false alarm crying wolf, and there was no problem?

Correct, it was my fault for not running the locally-compiled version of
git the correct way to get consistent invocation of subprocesses.  So
there was no problem.

...but there arguably *is* a metaproblem, namely that the obvious naive
way to invoke a locally-compiled test version of git without installing
it neither works correctly nor fails loudly.  It sometimes works (if the
main process doesn't need to call any subprocesses), sometimes works
accidentally (if the subprocess that is used happens to have the
behavior expected by the test version) and sometimes fails bizarrely (as
in my case and other cases recently mentioned on the mailing list).

I can think of a few ugly hacks that could improve the situation:

1. Don't compile executables into the project root directory, but rather
into a subdirectory named something awful like
"do-not-run-commands-from-this-directory" with a big README.txt in the
directory explaining how the commands *should* be run.  Even knowing
that one has to RTFM would be a help.

2. Include a special file like "GIT-DEV-SETUP" in the directory to which
the executables are compiled, but don't copy this file to $BINDIR when
git is installed.  Teach git commands to check for the presence of
$(dirname $0)/GIT-DEV-SETUP, and if found, do the equivalent of "exec
GIT-DEV-SETUP "$@"" or maybe just read and use some values out of
GIT-DEV-SETUP to set up the correct environment.  There could be some
environment variable like GIT_SETUP_DONE to prevent recursion and/or
allow this step to be bypassed.

3. Have git commands tell git subcommands what version they are
expecting (either via an environment variable or via a hidden
command-line parameter), and have the subcommand barf if the version
does not match its own internal version.  This approach is more
intrusive but would also help defend against inconsistently-installed
versions (like having one version installed in /usr/bin and fragments of
another version installed in $HOME/bin).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
