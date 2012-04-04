From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2 1/2] fast-import: test behavior of garbage after mark
 references
Date: Tue, 3 Apr 2012 20:46:10 -0400
Message-ID: <20120404004610.GA4124@padd.com>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
 <1333417910-17955-2-git-send-email-pw@padd.com>
 <20120403140055.GC15589@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 02:46:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFEMe-0000Kf-GD
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 02:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab2DDAqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 20:46:14 -0400
Received: from honk.padd.com ([74.3.171.149]:44033 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754946Ab2DDAqN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 20:46:13 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 91B4F20CE;
	Tue,  3 Apr 2012 17:46:12 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 1FE73313CD; Tue,  3 Apr 2012 20:46:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20120403140055.GC15589@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194674>

jrnieder@gmail.com wrote on Tue, 03 Apr 2012 09:00 -0500:
> Pete Wyckoff wrote:
> > +
> > +#
> > +# filemodify, three datarefs
> > +#
> > +test_expect_failure 'S: filemodify markref no space' '
> 
> What is this testing for?  The ideal is that each test_expect_foo line
> contains a proposition and the test checks whether that proposition is
> true or false.  For example:
> 
> 	test_expect_failure 'S: filemodify with garbage after mark errors out' '
> 
> Likewise in later tests.

I've fixed these locally, thanks for reading them!

> > +	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
> > +	commit refs/heads/S
> > +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> > +	data <<COMMIT
> > +	commit N
> > +	COMMIT
> > +	M 100644 :103x hello.c
> > +	EOF
> > +	cat err &&
> > +	grep -q "Missing space after mark" err
> 
> Is this using "grep -q" to avoid repeating the same line in the output
> twice?  It seems better to use plain grep or test_i18ngrep.
> 
> I'm also worried that if someone wants to change these messages
> (perhaps to make the 'm' in "Missing" lowercase or something), they
> will have to change all of these tests.  If we want to be absolutely
> sure that git detects the right error instead of something else, I
> would suggest
> 
> 	test_i18ngrep "space after mark" message
> 
> I'm also not convinced the error message is worth checking at all ---
> as long as fast-import errors out, won't the frontend author be able
> to look in the logs to find out the problematic line anyway?

I'm a bit confused.  I read through 5e9637c (i18n: add
infrastructure for translating Git with gettext, 2011-11-18), and
GETTEXT_POISON seems to be used to find untranslated messages.
What I want to test here is that the functionality works: do the
right untranslated messages get printed.

Changing the "Missing" to "missing" would require fixing the
tests, and that seems okay.

I'm happy to drop the "-q" and drop the "Missing", but wonder if
you're looking for something deeper.

> > +test_expect_failure 'S: filemodify inline no space' '
> > +	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
> > +	commit refs/heads/S
> > +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> > +	data <<COMMIT
> > +	commit N
> > +	COMMIT
> > +	M 100644 inlineX hello.c
> > +	data <<BLOB
> > +	inline
> > +	BLOB
> > +	EOF
> > +	cat err &&
> > +	grep -q "Missing space after .inline." err
> 
> Does this fail because the error message is "Missing space after SHA1"
> instead?  I'm not sure that's actually a bug, unless we want to
> correctly nitpick that the keyword "inline" that is a stand-in for an
> object name is not itself one.

The form of the message matters.  Datarefs can be inline, SHA1s,
or marks.  It is confusing to see an error message about a SHA1
when the input stream has no SHA1s.  The existing code always
says "SHA1", which is wrong if you gave it a mark or an inline.

> I don't think the tests for exact error messages make too much sense
> without the next patch, so I would suggest leaving them out if this
> patch is supposed to be applicable on its own.
> 
> Thanks for some thorough tests.

You think I should squash it all together, then?  Or factor the
tests into two chunks:
    - tests for behavior that silently accepts broken input; and,
    - tests for behavior where the bogus input is detcetd, but
      incorrect error messages are given?

		-- Pete
