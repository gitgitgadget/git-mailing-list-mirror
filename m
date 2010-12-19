From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 3/4] userdiff: fix typo in ruby and python word regexes
Date: Sun, 19 Dec 2010 03:10:43 +0100
Message-ID: <201012190310.43308.trast@student.ethz.ch>
References: <cover.1292688058.git.trast@student.ethz.ch> <a358c476187b1220bf6e2368c0723cefe60a5763.1292688058.git.trast@student.ethz.ch> <7vr5deg5fp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 19 03:11:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU8kP-0007ia-80
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 03:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247Ab0LSCKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 21:10:46 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:15853 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932191Ab0LSCKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 21:10:45 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 19 Dec
 2010 03:10:43 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 19 Dec
 2010 03:10:44 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <7vr5deg5fp.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163947>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > Both had an unclosed ] that ruined the safeguard against not matching
> > a non-space char.
> 
> Thanks.
> 
> Couldn't we have found this without your "sanity check" patch?  Are we
> ignoring error returns from regcomp() in some codepath, or is it just that
> we are catching them but our test suite lacks ruby and python test
> vectors?

We lacked test vectors, but we still couldn't have caught it.  We do
check for errors in regcomp():

	if (o->word_regex) {
		ecbdata.diff_words->word_regex = (regex_t *)
			xmalloc(sizeof(regex_t));
		if (regcomp(ecbdata.diff_words->word_regex,
				o->word_regex,
				REG_EXTENDED | REG_NEWLINE))
			die ("Invalid regular expression: %s",
					o->word_regex);
	}

(Now that I'm seeing this and comparing with regcomp(3), we should
actually report regerror() as part of the error message.)

The problem is that the pattern is still valid.  Consider that it was
a final two arms to the regex:

-        "|[^[:space:]|[\x80-\xff]+"),
+        "|[^[:space:]]|[\x80-\xff]+"),

In the preimage, it parses like so:

  | [^
      [:space:]|[\x80-\xff
     ]+

That is, the third [ is part of the (negated) character class.  So the
only problem is with | or [ characters in the input.  Any other
non-space character is part of the class.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
