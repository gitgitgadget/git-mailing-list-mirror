From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH v2 0/4] more automation for cover letter generation
Date: Mon,  4 May 2009 11:58:58 +0200
Message-ID: <1241431142-8444-1-git-send-email-ft@bewatermyfriend.org>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 11:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0uxe-0007gz-LD
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 11:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbZEDJ7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 05:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbZEDJ7f
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 05:59:35 -0400
Received: from smtprelay07.ispgateway.de ([80.67.29.7]:40909 "EHLO
	smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbZEDJ7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 05:59:30 -0400
Received: from [212.117.84.176] (helo=fsst.voodoo.lan)
	by smtprelay07.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M0uxK-0001t7-D4; Mon, 04 May 2009 11:59:26 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M0uwx-0002Ck-Jw; Mon, 04 May 2009 11:59:03 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118223>

Sorry for taking this long, I was covered in work.

Junio C Hamano <gitster@pobox.com> wrote:
> Frank Terbeck <ft@bewatermyfriend.org> writes:
> > [format]
> >     coverletter = true
> >     coveronepatch = false
> 
> Nobody wants a cover letter to a single patch, so a better way
> would probably be:
> 
> 	'yes' means default behaviour, that is add cover letter for
> 	multiple-patch series, non for a single patch;
> 
> 	'no' means no cover; and
> 
> 	'always' means a probably insane "cover even a single patch".
> 
> In any case, because this new feature is way too late to be in the
> upcoming 1.6.3 release anyway, I think it is a saner approach to add a
> command line option "--cover=yes" to "cover if multiple", "--cover=always"
> to "cover even a single patch", and "--cover=no" to countermand a
> configured "format.cover" the user may have in the configuration from the
> command line.

You're right. And so is Jeff.
I'll send a followup, that will address comments of the both of you.
See below.

> 
> >     overwritecoverletter = false
> 
> I do not think it is particularly a good idea, and it is a good idea to
> have it in the configuration.
> 
>  - Why not protect the earlier patch output?  People often tweak messages
>    (both above and below the three-dash lines) in them.
> 
>  - Isn't this pretty much per invocation?
> 
> I can understand (I may not be enthused about it) a new --clobber={yes,no}
> command line option to allow/forbid clobbering the existing files, and you
> may want to add --clobber=patches to allow clobbering only the patches but
> not cover (which I do not think makes much sense, though).

This was a followup idea, which I thought was a reasonable. In the
meantime, I feel this is not needed. I'd agree that a more generic
--clobber option would make sense but frankly, protecting overwrites at
this stage is not something worth putting much effort into, IMHO.

Jeff King <peff@peff.net> wrote:
> On Sat, Apr 18, 2009 at 06:16:15PM +0200, Frank Terbeck wrote:
[...]
> Something about "coveronepatch" seems a bit hack-ish to me. Perhaps it
> should be "generate cover letter if there are more than N patches". You
> could even just overload "format.coverletter" as:
> 
>   true - always generate cover letter
>   false - never generate cover letter
>   <number> - generate if there are at least <number> patches

Yeah, a lot better.
As Junio said, noone wants cover letters for single patches.
Therefore, I made format.coverletter default to 2. Setting it to one
makes --cover-letter produce for cover letter for single patches, too.
Setting it to 0 disables cover letters, even with --cover-letter. Any
other value sets the minimum size of patch series that will trigger
--cover-letter to create a cover letter.

That can be altered from the command-line via:
    --cover-letter=always
    --cover-letter=never
    --cover-letter=<length>

In addition to that I did add format.coverauto.
Setting it to true (it defaults to false) makes format-patch behave like
the user gave the --cover-letter option - with the following exception:
if --stdout is specified, cover letters are disabled. To force cover
letters in that case too, --cover-letter needs to be specified *after*
--stdout.

Now that I think of it again, two weeks after writing this mail
originally, I guess it would be possible to drop format.coverauto
altogether and tell users to use:

  % git config --global alias.fp format-patch --cover-letter

I don't know which solution would be preferred. If it's the user-should-
use-an-alias approach, I'll create a series that gets rid of
format.coverauto changes.

[...]
> > The series is based on master and doesn't seem to break anything
> > within the test suite. It could maybe use own tests, but I must admit
> > that I didn't look too closely at how git's test suite works and where
> > to put in tests for this.
> 
> The tests below were not actually run (and you can see they are based on
> what I proposed above, not your existing patches), but they should give
> hopefully give you a headstart.

Yes, it did. Thank you.

Frank Terbeck (4):
The new options and changes:
  Add format.coverletter option
  Add format.coverauto boolean

Tests, thanks to Jeff:
  Add tests for coverauto, coverletter and --cover-letter

And finally documentation.
  Documentation for format.coverletter and --cover-letter

 Documentation/config.txt           |    9 +++++
 Documentation/git-format-patch.txt |   17 ++++++++--
 builtin-log.c                      |   32 +++++++++++++++++--
 t/t3400-rebase.sh                  |    1 +
 t/t4014-format-patch.sh            |   58 ++++++++++++++++++++++++++++++++++-
 5 files changed, 108 insertions(+), 9 deletions(-)
