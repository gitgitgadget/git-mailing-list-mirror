From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http.c: add http.sslCertType and http.sslKeyType
Date: Mon, 15 Jun 2009 23:47:32 -0700
Message-ID: <7vd494eku3.fsf@alter.siamese.dyndns.org>
References: <1245033541-15558-1-git-send-email-lodatom@gmail.com>
	<1245033541-15558-2-git-send-email-lodatom@gmail.com>
	<alpine.OSX.2.00.0906151927010.816@xor.localnet>
	<ca433830906151755t783fbf98k3fd09e4bdd6781e8@mail.gmail.com>
	<7vprd4g1rv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Weiss <knweiss@gmx.de>, git@vger.kernel.org,
	Daniel Stenberg <daniel@haxx.se>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 08:47:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGSSM-0004lw-QL
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 08:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbZFPGrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 02:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754465AbZFPGra
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 02:47:30 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:43638 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbZFPGra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 02:47:30 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090616064732.TSRF20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Tue, 16 Jun 2009 02:47:32 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 4WnY1c0034aMwMQ04WnYUW; Tue, 16 Jun 2009 02:47:32 -0400
X-VR-Score: -300.00
X-Authority-Analysis: v=1.0 c=1 a=M82w0W_vP8cA:10 a=ybZZDoGAAAAA:8
 a=_QMLVz0yR2xaW17IcJUA:9 a=BEa3fW_uKcfsgoocLmEA:7
 a=WvwHLXLnkGsN7mrgkYmxxS5dd8EA:4 a=qIVjreYYsbEA:10 a=mGapZSn-PWbpCUv6:21
 a=PBr9gkIdZV8K6dXH:21
X-CM-Score: 0.00
In-Reply-To: <7vprd4g1rv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 15 Jun 2009 22\:56\:20 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121659>

Junio C Hamano <gitster@pobox.com> writes:

> I agree that would be a better approach in the longer term.  There is no
> point in many projects that use libcURL reinventing the wheel that could
> be in the shared library.
>
> Perhaps we could do both ;-).
>
> That is, (1) give libcURL a way to allow callers ask if the key/cert is
> encrypted, and then (2) on git side we only add code to ask libcURL using
> that interface _only if and when available_; otherwise we do not even try
> to bypass layers but just ask the user to tell us via configuration (or
> command line).

I guess I somewhat misread what you were saying (and I seem to be doing
this more often recently---I should slow down).

For key/cert type, the current cURL interface you used expects the caller
to say "I am giving you the name of the cert file, and the file is of this
type".  I think the usability enhancement would be something like "Here is
the cert file; it should be one of the types supported by you (I do not
know nor care what exact type it is, but the end user tells me that you
should be able to use it).  Please do whatever necessary with it."

For key/cert passphrase, the current cURL interface we use expects the
caller to give a string value via setopt.  I wonder if there already is an
existing interface to give a callback function that is responsible for
doing user interaction and return a string?  The best case would be to use
such an interface if available; otherwise, it would be good to add such an
interface to libcURL for us and other people to use.

I imagine the user would look something like this:

	static char *ssl_cert_password;
	static const char *callback(const char *hint, int trial, void *cb)
        {
		char buf[256];
                if (!trial)
                	return ssl_cert_password ? ssl_cert_password : "";
		if (5 < trial) {
			error("Wrong passphrase. Giving up...");
			return NULL;
                }
		sprintf(buf, "Passphrase to unlock %s: ", hint);
                ssl_cert_password = getpass(buf);
                return ssl_cert_password;
        }

where

 (1) The calling program (i.e. us) sets the address of the callback
     function via curl_easy_setopt() when registering a key/cert file;

 (2) When libcURL needs to unlock the key/cert file and sees such a
     callback registered, it is called with "hint" (probably the filename
     of the key/cert file it is trying to unlock), trial count (initially
     zero) and an arbitrary callback data the program passed when it
     registered the callback in the step (1).  The callback is expected to
     return a passphrase string.

 (3) The callback can return an empty string to tell the library to try
     using an empty passphrase (aka unencrypted keyfile).

 (4) If the returned string does not unlock the key/cert file
     successfully, libcURL is expected to call the callback with the same
     hint/cb but trial count incremented.  The callback can return NULL to
     signal that the user/program gave up.

That way, we wouldn't even have to make a "trial connection" we earlier
discussed.  The first request to make a connection we make into the
library can also serve as the "trial connection".
