From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 3/4] commit test: test_set_editor in each test
Date: Fri, 13 Jun 2014 02:59:42 -0400
Message-ID: <20140613065942.GB7908@sigill.intra.peff.net>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
 <1402601942-45553-4-git-send-email-caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Burns <mike@mike-burns.com>
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Fri Jun 13 08:59:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvLSm-0001m2-Nl
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 08:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbaFMG7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 02:59:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:43208 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750862AbaFMG7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 02:59:44 -0400
Received: (qmail 7848 invoked by uid 102); 13 Jun 2014 06:59:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 01:59:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 02:59:42 -0400
Content-Disposition: inline
In-Reply-To: <1402601942-45553-4-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251520>

On Thu, Jun 12, 2014 at 02:39:01PM -0500, Caleb Thompson wrote:

> t/t7507-commit-verbose.sh was using a global test_set_editor call to
> build its environment.
> 
> Improve robustness against global state changes by having only tests
> which intend to use the $EDITOR to check for presence of a diff in the
> editor set up the test-editor to use check-for-diff rather than relying
> upon the editor set once at script start.

This implies to me that EDITOR is unset after leaving these tests. I
don't think that is how it works, though.  The tests themselves run in
the main environment of the test script. A call to test_set_editor from
one of them will still affect the other tests[1].

I think it works anyway because every subsequent test that cares
actually sets the editor itself.

Or did you just mean that the new rule is "every test sets the editor as
they need", which means that we do not have to worry anymore about
polluting the environment for other tests?

-Peff

[1] It might make sense for test_set_editor, when run from within a
    test, to behave more like test_config, and do:

      test_when_finished '
        sane_unset FAKE_EDITOR &&
        sane_unset EDITOR
      '

    I don't know if there would be fallouts with other test scripts,
    though.
