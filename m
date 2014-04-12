From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: On "interpret-trailers" standalone tool
Date: Sat, 12 Apr 2014 21:30:03 +0200 (CEST)
Message-ID: <20140412.213003.73509455950485398.chriscool@tuxfamily.org>
References: <xmqq61mi1djt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 12 21:30:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ3dg-0002Oc-6z
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 21:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbaDLTaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 15:30:08 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:35456 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754472AbaDLTaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 15:30:07 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id DB5BA49;
	Sat, 12 Apr 2014 21:30:03 +0200 (CEST)
In-Reply-To: <xmqq61mi1djt.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246177>

From: Junio C Hamano <gitster@pobox.com>
>
> So far I've mostly been ignoring how the command line would look
> like,

I don't really feel this way ;-)

> because the intermediate goal to my mind was to have it as a
> hook that are added by people better versed with Git than an average
> end-user, and if the command line interface had to change then they
> are capable of updating it, so it is more acceptable than the usual
> end-user tools to break compatibility between an early prototype and
> later versions, and because the final goal would be to libify the
> internal logic and integrate it into places we would invoke hooks,
> making the standalone command irrelevant.
> 
> However, I started to care ;-)  For example, wouldn't it be nice if
> you can do
> 
>     $ git format-patch -5 --cover-letter -o +my-series/ my-topic
>     $ git interpret-trailers "some args" ./+my-series/0*.patch
> 
> to fix-up the "trailers" portion of the proposed log message in the
> formatted patches?  There may be other possible uses that having a
> standalone tool would be helpful, even after we removed the need for
> such a tool from commit, rebase, etc. by integrating the internal
> logic to the implementation of these commands.
> 
> However, I am wondering if the current "everything on the command
> line is instruction to the command" is too limiting to allow the use
> of the tool both as a filter and as a tool that can work on one or
> more files named on the command line.  If we start from there, the
> only way to later add "these arguments are names of the files to be
> operated on" is to add "--file <file1> --file <file2>..." options,
> which feels quite backwards as a UNIX tool.

Yeah, except that we could add for example a '-o' option that would
take a directory as argument and that would mean that the command
should operate on all the files in this directory. It would be like
the -o option of the format-patch command.

> It would be easier to explain and understand if the command line
> option set is modeled after things like "cat" or "sed", where
> non-option arguments are filenames, instructions are given in the
> form of "--option <arg>" (e.g. "-e 's/foo/bar/'" given to sed), and
> having no non-option arguments on the command line signals that the
> tool is working as a filter.

Yeah, that's an interesting idea. I am not against making yet another
number of changes to "git interpret-trailers" to make something like
the above possible. But I think there are a few things that should be
discussed first.

First, if you think that the command might often be used along with
format-patch, then it might be interesting for the user to have the
command behave like format-patch instead of like cat or sed. This
means that we could add the -o option I suggest above. And we don't
need to do it now. We could add this option later instead of having to
make the command work on many files now.

Second, if the command should accept a patch as input instead of just
a commit message, or both, this means that the command should have a
way to tell if it is passed a patch, and then locate the commit
message part in the patch. This means yet other changes to the
command. Maybe these changes could be made later, in another series,
or when the need arises to use it on full patches.

Third, if trailers arguments are passed to the command using an option
like "-z token=value" or "-z token:value", it would be nice to the
user for consistency if the same option could be used when passing the
same arguments to "git commit" and perhaps other commands like "git
rebase", "git cherry-pick" and so on. This means that we now have to
choose carefully the name of this option. Perhaps we can just give it
a long name now like --trailer and care later about a short name, but
I think it would not be very nice to the user to only have a long name
for this option as it will very often be used.

Fourth, some users might want the command to be passed some files as
input, but they might not want the command to modify these input
files. They might prefer the command to write its ouput into another
set of output files. Maybe a syntax like cat or sed is not very well
suited for this kind of use, while having a -o option for the output
directory and a -i option for the input directory (if different from
the output dir) would be nicer.

Thanks,
Christian.
