From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] mergetool: support absolute paths to tools by git config merge.<tool>path
Date: Tue, 9 Oct 2007 08:30:39 +0200
Message-ID: <C52FC9BE-13EE-4CB7-A5E9-164A2AC0E2E7@zib.de>
References: <11918785613855-git-send-email-prohaska@zib.de> <20071008215729.GC31713@thunk.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 09 08:29:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If8ap-0000vB-Tm
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 08:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbXJIG3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 02:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbXJIG3M
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 02:29:12 -0400
Received: from mailer.zib.de ([130.73.108.11]:45660 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400AbXJIG3K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 02:29:10 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l996T7G9012852;
	Tue, 9 Oct 2007 08:29:07 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1f6fc.pool.einsundeins.de [77.177.246.252])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l996T67h002008
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 9 Oct 2007 08:29:06 +0200 (MEST)
In-Reply-To: <20071008215729.GC31713@thunk.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60361>


On Oct 8, 2007, at 11:57 PM, Theodore Tso wrote:

> On Mon, Oct 08, 2007 at 11:22:40PM +0200, Steffen Prohaska wrote:
>> This commit adds a mechanism to provide absolute paths to the
>> commands called by 'git mergetool'. A path can be specified
>> in the configuation variable merge.<toolname>path.
>
> This patch doesn't work if the config file doesn't specify an explicit
> mergetool via merge.tool.   The reason for that is this loop:
>
>     for i in $merge_tool_candidates; do
>         if test $i = emerge ; then
>             cmd=emacs
>         else
>             cmd=$i
>         fi
>         if type $cmd > /dev/null 2>&1; then
>             merge_tool=$i
>             break
>         fi
>     done
>
> is only checking to see if $cmd is in the path; it's not looking up
> the merge.<toolname>path variable in this loop.

I didn't change the automatic detection. It should work as before.
That is it continues to assume that merge tools are in PATH.

Is you expectation that git-mergetool should also consider the
absolute paths provided in merge.<toolname>path?

When I wrote the patch I had in mind that people will set the
merge.tool explicitly if they provide an absolute path. Automatic
detection would only be used if nothing is configured. In this
case a tool must be in PATH or would not be found.


> I guess the other question is whether we would be better off simply
> telling the user to specify an absolute pathname in merge.tool, and
> then having git-mergetool strip off the directory path via basename,
> and then on window systems, stripping off the .EXE or .COM suffix, and
> then downcasing the name so that something like "C:\Program
> Files\ECMerge\ECMerge.exe" gets translated to "ecmerge".  Would I be
> right in guessing that the reason why you used merge.<toolname>path
> approach was to avoid this messy headache?

Yes. The program to start ECMerge on Windows is called 'guimerge.exe'.
Hard to derive a sensible short name from this.

So I don't think that an automatic translation is an option. I prefer
to provide the absolute paths.

Absolute paths have another advantage. You can set several of them
and choose a tool on the command line. Maybe you have several tools
you want to try. Or you hacking with someone else who preferes a
different tool. Or you just want to give a demo. I see
merge.<toolname>path more as a database associating absolute paths
with the shortnames.

My mental model is as follows:
1) merge.tool selects the mechanism needed to call the tool, that is
command line arguments, how merge result is passed, ...
2) merge.<toolname>path provides additional information how to locate
the selected tool in the filesystem.

The two points are somewhat orthogonal. I'd not fuse them into one.

	Steffen
