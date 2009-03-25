From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [BUG] Infinite loop in git send-email if ran non-interactively.
Date: Wed, 25 Mar 2009 10:36:55 +0100
Message-ID: <vpqiqlyj64o.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>, Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 10:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmPcV-0006PP-44
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 10:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbZCYJjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 05:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbZCYJjk
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 05:39:40 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:40240 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbZCYJjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 05:39:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n2P9atIZ028594;
	Wed, 25 Mar 2009 10:36:55 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LmPXb-0002k3-9V; Wed, 25 Mar 2009 10:36:55 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LmPXb-0005oN-7E; Wed, 25 Mar 2009 10:36:55 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 25 Mar 2009 10:36:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114577>

Hi,

I've been hit by c1f2aa45b (send-email: add --confirm option and
configuration setting) running git send-email from a cron job.

The problem is that the cron job is ran non-interactively, and
therefore the confirmation question in git-send-email.perl goes
infinite loop:

		while (1) {
			chomp ($_ = $term->readline(
				"Send this email? ([y]es|[n]o|[q]uit|[a]ll): "
			));
                        print "answer=$_.\n";
			last if /^(?:yes|y|no|n|quit|q|all|a)/i;
			print "\n";
		}

Infinite loop is bad, but it gets even worse since this prints error
messages to stdout, and therefore to a log file in the case of my
script. In short, I woke up this morning with a file filling my disk
with

print() on closed filehandle FOUT at /usr/share/perl/5.8/Term/ReadLine.pm line 193.
readline() on closed filehandle FIN at /usr/share/perl/5.8/Term/ReadLine.pm line 395.
print() on closed filehandle FOUT at /usr/share/perl/5.8/Term/ReadLine.pm line 203.
Use of uninitialized value in scalar chomp at /home/moy/local/usr/libexec/git-core//git-send-email line 856.
Use of uninitialized value in pattern match (m//) at /home/moy/local/usr/libexec/git-core//git-send-email line 859.
print() on closed filehandle FOUT at /usr/share/perl/5.8/Term/ReadLine.pm line 193.
readline() on closed filehandle FIN at /usr/share/perl/5.8/Term/ReadLine.pm line 395.
print() on closed filehandle FOUT at /usr/share/perl/5.8/Term/ReadLine.pm line 203.
Use of uninitialized value in scalar chomp at /home/moy/local/usr/libexec/git-core//git-send-email line 856.
Use of uninitialized value in pattern match (m//) at /home/moy/local/usr/libexec/git-core//git-send-email line 859.
...

I think, non-interactive runs of send-email should assume "yes"
instead of prompting. In any case, it should not do infinite loop (I
guess I don't have to argue for this ;-) )

Can someone more fluent in perl than me add a

if(session-is-interactive) {
...
}

around this confirmation prompt?

(side-note : there is indeed some code to handle the cases where the
terminal doesn't work with readline, added by Junio in 280242d1, but
the FakeTerm part doesn't seem to be executed in my case:

my $term = eval {
	$ENV{"GIT_SEND_EMAIL_NOTTY"}
		? new Term::ReadLine 'git-send-email', \*STDIN, \*STDOUT
		: new Term::ReadLine 'git-send-email';
};
if ($@) {
	$term = new FakeTerm "$@: going non-interactive";
}
)

(in the meantime, I'll add --confirm never to my script)

Thanks,

--
Matthieu
