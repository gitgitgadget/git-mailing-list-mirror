From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2ter 2/2] gitweb: clean up gitweb_check_feature() calls
Date: Sat, 29 Nov 2008 12:39:55 -0800
Message-ID: <7vej0u1d2c.fsf@gitster.siamese.dyndns.org>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1227959616-8056-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 21:41:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6WdL-0001FM-Sg
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 21:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbYK2Uk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 15:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbYK2Uk1
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 15:40:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYK2Uk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 15:40:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 652B482A40;
	Sat, 29 Nov 2008 15:40:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 46C4B82A3C; Sat,
 29 Nov 2008 15:39:57 -0500 (EST)
In-Reply-To: <1227959616-8056-1-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Sat, 29 Nov 2008 12:53:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F04C63D0-BE55-11DD-A33E-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101925>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Since gitweb_check_feature now returns a scalar, the parentheses around
> the variables initialized from gitweb_check_feature() are not needed.

Here is what I think the commit message of your [1/2] should have read:

    Subject: [PATCH] gitweb: make gitweb_check_feature a boolean wrapper

    The gitweb_check_feature() function retrieves the configuration
    parameters for the feature (such as the list of snapshot formats or
    the list of additional actions), but it is very often used to see if
    feature is enabled (which is returned as the first element in the
    list).

    Because accepting the returned list in a scalar context by mistake
    yields the number of elements in the array, which is non-zero in all
    cases, such a mistake would result in a bug for the latter use, with
    disabled features appearing enabled.  All existing callers that call
    the function for this purpose assign the return value in the list
    context to retrieve the first element, but this is a bug waiting to
    happen for future callers that are not careful.

    This changes gitweb_check_feature() to a wrapper that can be called
    safely in the scalar context to see if a feature is enabled to reduce
    the risk of future bugs.  A new function gitweb_get_feature() is
    introduced for the callers that want the list of configuration
    parameters.  All existing callers of gitweb_check_feature() that want
    the configuration parameters are adjusted to call gitweb_get_feature().

Notice the difference in the tone from your [1/2].  The change is not
about fixing (your proposed commit log message read "gitweb:fixes to
gitweb feature check code") as nothing is broken.  It is purely about
futureproofing and I think we should mark it as such.

The splitting of two patches is not strictly necessary, but if you wanted
to, I would do so slightly differently:

 * Make [1/2] purely the rename of s/check/get/, saying "the function is
   not just checking if it is enabled, but it is getting the configuration
   parameter list.  I'll introduce a new API to ask if it is enabled,
   which will be called 'check', hence this rename".

   Obviously, after applying this patch, there should be no caller of
   "check".

 * Make [2/2] introduce the "check" wrapper, and change the existing
   callers of "get" that want boolean to call "check" (and in the scalar
   context, as it does not matter anymore).  You can steal most of the
   above rewrite as your commit message for this (except for the last two
   sentences).

Also I would rewrite the mysterious "Comfort code" comment like this:

        # A wrapper to check if a given feature is enabled.
        # With this, you can say
        #
        #   my $bool_feat = gitweb_check_feature('bool_feat');
        #   gitweb_check_feature('bool_feat') or somecode;
        #
        # instead of
        #
        #   my ($bool_feat) = gitweb_get_feature('bool_feat');
        #   (gitweb_get_feature('bool_feat'))[0] or somecode;

(you also had a few typos in these four example calls).
