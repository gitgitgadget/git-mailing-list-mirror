From: Aaron Crane <git@aaroncrane.co.uk>
Subject: Re: [PATCHv2] gitweb: gravatar support
Date: Sat, 20 Jun 2009 15:16:27 +0100
Message-ID: <20090620141626.GK7675@aaroncrane.co.uk>
References: <1245435670-5688-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 16:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI1k3-0000DP-VH
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 16:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbZFTOkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 10:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZFTOkD
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 10:40:03 -0400
Received: from bluebeard.laxan.co.uk ([81.21.79.10]:42099 "EHLO
	bluebeard.laxan.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbZFTOkC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 10:40:02 -0400
X-Greylist: delayed 1414 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jun 2009 10:40:02 EDT
Received: from marchmont.aaroncrane.co.uk ([87.194.157.167] helo=sunset)
	by bluebeard.laxan.co.uk with esmtpa (Exim 4.63)
	(envelope-from <git@aaroncrane.co.uk>)
	id 1MI1Mp-0004ul-Q0; Sat, 20 Jun 2009 15:16:27 +0100
Received: by sunset (Postfix, from userid 1000)
	id 25E484F0502; Sat, 20 Jun 2009 15:16:27 +0100 (BST)
Mail-Followup-To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <1245435670-5688-1-git-send-email-giuseppe.bilotta@gmail.com>
Mail-Copies-To: nobody
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121944>

Giuseppe Bilotta writes:
> +# check if gravatars are enabled and dependencies are satisfied
> +our $git_gravatar_enabled = gitweb_check_feature('gravatar') &&
> +	(eval { use Digest::MD5 qw(md5_hex); 1; });

This test for the availability of Digest::MD5 is broken: `use`
statements are executed at compile time, so the whole program will
fail if Digest::MD5 can't be loaded.

A possible fix would be to move the compile-time actions to run time:

    our $git_gravatar_enabled = gitweb_check_feature('gravatar') &&
         (eval { require Digest::MD5; Digest::MD5->import('md5_hex'); 1 });

However, I don't recommend doing that.  Digest::MD5 is a core module
in Perl 5.8.0 and later, so an installation of Perl 5.8 that doesn't
have it is broken.  Since gitweb.perl already needs 5.8 (because of
the `binmode STDOUT, ':utf8'` at the top, if nothing else) I see no
value in jumping through hoops to make this work in the essentially
impossible situation where Digest::MD5 is unavailable.

-- 
Aaron Crane ** http://aaroncrane.co.uk/
