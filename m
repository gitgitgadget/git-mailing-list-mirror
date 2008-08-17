From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Sun, 17 Aug 2008 16:15:30 +0200
Message-ID: <20080817141530.GA4542@efreet.light.src>
References: <20080808211318.GA4396@efreet.light.src> <e5bfff550808170157m45532428y3956e5d0d92e97d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 16:16:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUj3g-0006Vc-BV
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 16:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbYHQOPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 10:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbYHQOPg
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 10:15:36 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:58576 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbYHQOPg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 10:15:36 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 10AB3573C6;
	Sun, 17 Aug 2008 16:15:35 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id FC9zS8weCNSn; Sun, 17 Aug 2008 16:15:32 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 149BF573F3;
	Sun, 17 Aug 2008 16:15:32 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KUj2Y-0001Fj-M8; Sun, 17 Aug 2008 16:15:30 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550808170157m45532428y3956e5d0d92e97d9@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92612>

On Sun, Aug 17, 2008 at 09:57:36 +0100, Marco Costalba wrote:
> On Fri, Aug 8, 2008 at 10:13 PM, Jan Hudec <bulb@ucw.cz> wrote:
>   sorry to reply so late but I just returned from holiday (no PC there
> due to it was severely forbidden by my boss aka wife :-)

That's all right. I am not progressing that fast.

> > I've been thinking about some refactoring of QGit since some time. And to be
> > sure I don't screw up things too hard in the process, I thought about adding
> > a test suite infrastructure first (and add some test cases for each think
> > just before refactoring it).
> That's interesting. I have NO experience on test suites for GUI
> applications (command line applications like git I would think are
> easier to setup some tests suite for)

Well, there are basically three points at which GUI application can be
tested:
 1. The code that provides data does not directly do anything with graphics
    and therefore can be tested by normal unittests. In this case such tests
    can be written for the Git and related classes.
 2. Widget events can be emulated inside the test driver, for which Qt4
    contains a (quite basic but usable) QTestlib module. The tests work as
    normal unittests.
 3. User interaction can be simulated from outside the application, eg. with
    LDTP.

I actually plan the first two items. While the third would be less invasive
(no need to link anything anywhere), unittests are much more useful for
debugging, because you can test individual functions independently.

> > The problem is, that implementing unittests means I need to compile
> > 2 separate binaries -- qgit itself and the test -- using most (but not all)
> > of the same sources. I see two ways to do it, so I'd like to ask which you
> > consider cleaner:
> >
> >  1. Reorganize stuff so that a (static) library is created from all the
> >    sources except qgit.cpp and than qgit.cpp is linked to this library to
> >    create qgit and the tests are linked with it to provide the test runner.
> >
> >    Pros:
> >     - The .pro files should remain reasonably simple.
> >     - The sources are only compiled once.
> >    Cons:
> >     - Need to split the src directory to two, so bigger moving stuff around.
> >
> 
> This is not a cons IMHO if it helps in separating tests from sources.

The tests would be a separate directory in any case. What I will need to
separate is qgit.cpp from all other sources. So there will be *three* folders
in the end -- one for linking the qgit binary, containing only qgit.cpp and
a .pro file, one for the majority of source and one for linking the testsuite
with the test sources.

> As I said I am no expert, but I would try to
> 
> - Let the test suite be easily stripped/not compiled for the
> publishing (remember that we have to produce also that little
> qgit_install.exe file used on *that* OS)

The test suite basically must be a separate binary. At least that's the only
method I ever used -- it would be possible to link everything together and
start the test suite using a parameter, but I don't intend to do that.

> - Let the test be compiled only on demand (during developing I just
> want to compile and run as few things as possible: C++ is already
> quite bad in that regard and I don't want the situation get worst. BTW
> I consider C++ slow compile times the biggest and probably only
> drawback of C++ against C for big projects)

Yes, you can just comment out the tests. On the other hand it's during the
development I normally want to run the tests. I usually prefer to write
a test for things I work on over starting the user interface and testing them
manually, because manual testing is much more prone to forgetting some
important corner cases.

> - Try to find some literature/reference before starting coding. As I
> said I am no expert of GUI testing, so I would probably try to find
> some Qt projects that use it and see/ask the developers how they
> managed to do that and what are the problems. Then try to be stick to
> known best practice (read someone that has DONE that in a REAL
> project, not someone that has WRITTEN about that in a paper or a
> vendor marketing/documentation)

Well, KDE people talked about doing it, but I am not sure how much they
actually do. But it's really just normal unit-testing.

> Anyhow I'm really interested in this thing, and hope to see your work
> soon. Please feel free to drop me a line for any help you think I can
> give you.

Bye,
Jan

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
