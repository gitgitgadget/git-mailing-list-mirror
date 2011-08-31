From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6] Add a remote helper to interact with mediawiki (fetch & push)
Date: Wed, 31 Aug 2011 19:30:25 +0200
Message-ID: <vpq7h5tbia6.fsf@bauges.imag.fr>
References: <1314381329-8989-1-git-send-email-Matthieu.Moy@imag.fr>
	<1314809708-8177-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAGdFq_gu=SyjUnUS1bcjPrcPPtKVt+UjDBvBmZqosk+OuDFDHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 19:31:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qyocx-0000EX-0R
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 19:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab1HaRa5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Aug 2011 13:30:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55070 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736Ab1HaRa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 13:30:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p7VHTj9o025065
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Aug 2011 19:29:45 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QyocM-00065W-6b; Wed, 31 Aug 2011 19:30:26 +0200
In-Reply-To: <CAGdFq_gu=SyjUnUS1bcjPrcPPtKVt+UjDBvBmZqosk+OuDFDHw@mail.gmail.com>
	(Sverre Rabbelier's message of "Wed, 31 Aug 2011 19:03:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 31 Aug 2011 19:29:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7VHTj9o025065
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315416590.66121@j8Gy+1873G9hJ4ltWzBq4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180497>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> 2011/8/31 Matthieu Moy <Matthieu.Moy@imag.fr>:
>> So, after understanding better how import works, here's an updated
>> patch that gets rid of the hacky workaround to terminate and send th=
e
>> "done" command at the right time.
>
> So what do you think of the way the protocol works now? Do you agree
> that (modulo lacking docs) it is better than previously?

I'm not sure I understood exactly how it was before, but the current
protocol seems indeed at least reasonable:

* It's possible to specify a batch of imports, so the remote-helper has
  freedom to optimize the import of multiple refs.

* A batch of import is clearly delimited, both on stdin and stdout, so
  it is possible to alternate import batches and other commands.

I still have a few complaints, because even with a better doc, I still
found the debugging a bit hard. To make it easy for remote-helpers
authors, I think the transport-helper could have an explicit "done"
command, so that the command stream look like

import foo
import bar
\n
done

instead of

import foo
import bar
\n
\n

and to let the remote-helper's code be like

while($cmd =3D <read command>) {
   if ($cmd eq "command1") {
       do something;
   } elsif ($cmd eq "command2") {
       something else;
   } elsif ($cmd eq "done") {
       exit properly;
   }
}

I'm not sure whether changing this now is worth the trouble though.

I'd have appreciated if the transport-helper had given me an explicit
error message when writting to a broken pipe too. I finally got it with
gdb, but lost some time trying to understand (especially painfull since
there was a race condition between the remote-helper termination and gi=
t
writting to it, so the bug wasn't reproducible).

>> Actually, push had the same problem but it just went unnoticed (the
>> remote has just one branch, so it's silly to try to push multiple
>> branches at the same time ...). This version handles push more
>> cleanly, giving accurate error message in cases like
>>
>> =A0git push origin :master
>> =A0git push origin foo bar master
>>
>> or perhaps more commonly
>>
>> =A0git push --all
>>
>> in a repository with branches other than master.
>
> My perl skills are minimal, but I'm curious how/where you implemented
> this?

Here:

+	for my $refspec (@refsspecs) {
+		unless ($refspec =3D~ m/^(\+?)([^:]*):([^:]*)$/) {
+			die("Invalid refspec for push. Expected <src>:<dst> or +<src>:<dst>=
");
+		}
+		my ($force, $local, $remote) =3D ($1 eq "+", $2, $3);

At this point, $force is a boolean saying whether there were a +, and
$local and $remote are as you can guess.

+		if ($force) {
+			print STDERR "Warning: forced push not allowed on a MediaWiki.\n";
+		}
+		if ($local eq "") {
+			print STDERR "Cannot delete remote branch on a MediaWiki\n";
+			print STDOUT "error $remote cannot delete\n";

print STDERR goes to the console (i.e. to the user), and print STDOUT
goes to the Git's transport-helper.

+			next;
+		}
+		if ($remote ne "refs/heads/master") {
+			print STDERR "Only push to the branch 'master' is supported on a Me=
diaWiki\n";
+			print STDOUT "error $remote only master allowed\n";
+			next;
+		}

> Is this something that we can port to remote-testgit to document the
> CPB on handling such things?

CPB =3D ?

Actually, my case is very particular, since the only thing to do with
branches is to make sure the user doesn't use them. In remote-testgit,
there are actually branches.

And testgit use the undocumented "export" feature, which does not seem
to support branch deletion:

git push origin :branch2
fatal: remote-helpers do not support ref deletion
moy@bauges:/tmp/clone$ Traceback (most recent call last):
  File "/home/moy/local/usr-squeeze/libexec/git-core/git-remote-testgit=
", line 252, in <module>
    sys.exit(main(sys.argv))
  File "/home/moy/local/usr-squeeze/libexec/git-core/git-remote-testgit=
", line 249, in main
    more =3D read_one_line(repo)
  File "/home/moy/local/usr-squeeze/libexec/git-core/git-remote-testgit=
", line 215, in read_one_line
    sys.stdout.flush()
IOError: [Errno 32] Broken pipe

(This comes from

transport-helper.c:750:                 die("remote-helpers do not supp=
ort ref deletion");

called before starting the exporter)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
