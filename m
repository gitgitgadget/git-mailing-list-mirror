From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: All gnupg tests broken on el4 [Re: [ANNOUNCE] Git v2.3.0-rc2]
Date: Thu, 29 Jan 2015 18:34:54 +0100
Message-ID: <54CA6F3E.4060804@statsbiblioteket.dk>
References: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com> <54CA3169.4020701@statsbiblioteket.dk> <20150129154319.GA742@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 18:35:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGsze-0002V2-LM
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 18:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbbA2Re7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 12:34:59 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:6263 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753623AbbA2Re6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2015 12:34:58 -0500
Received: from [172.18.234.199] (172.18.234.199) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.348.2; Thu, 29 Jan 2015 18:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
In-Reply-To: <20150129154319.GA742@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263155>

On 29/01/15 16:43, Jeff King wrote:
> Weird. The pubkeys are there in keyring.gpg; I wonder why the older
> version of gpg has trouble extracting them (and how one was _supposed_
> to export secret keys at that time).
>

Importing the unmodified keyring.gpg with 1.2.6 yields this:
$ gpg --homedir "$GNUPGHOME" --import /tmp/keyring.gpg
gpg: keyring `/home/tgc/gpghome/secring.gpg' created
gpg: keyring `/home/tgc/gpghome/pubring.gpg' created
gpg: key CDDE430D: secret key imported
gpg: key B7227189: secret key imported
gpg: Total number processed: 2
gpg:       secret keys read: 2
gpg:   secret keys imported: 2
$ gpg --homedir "$GNUPGHOME" --list-keys
$ gpg --homedir "$GNUPGHOME" --list-secret-keys
/home/tgc/gpghome/secring.gpg
-----------------------------
sec  1024D/CDDE430D 2007-06-07 C O Mitter <committer@example.com>
ssb  2048g/7703B0E5 2007-06-07

sec  2048R/B7227189 2013-03-22 Eris Discordia <discord@example.net>
ssb  2048R/29472784 2013-03-22
$

> So if I understand you correctly, the tests should pass with the patch
> below?
>

Yes, adding the pubkeys as a separate entity makes gpg 1.2.6 understand 
things fine.

gnupg 1.2.6 with the patched keyring:
$ gpg --homedir "$GNUPGHOME" --import /tmp/keyring.gpg
gpg: keyring `/home/tgc/gpghome/secring.gpg' created
gpg: keyring `/home/tgc/gpghome/pubring.gpg' created
gpg: key CDDE430D: secret key imported
gpg: key B7227189: secret key imported
gpg: /home/tgc/gpghome/trustdb.gpg: trustdb created
gpg: key CDDE430D: public key "C O Mitter <committer@example.com>" imported
gpg: key B7227189: public key "Eris Discordia <discord@example.net>" 
imported
gpg: Total number processed: 4
gpg:               imported: 2  (RSA: 1)
gpg:       secret keys read: 2
gpg:   secret keys imported: 2
$ gpg --homedir "$GNUPGHOME" --list-keys
/home/tgc/gpghome/pubring.gpg
-----------------------------
pub  1024D/CDDE430D 2007-06-07 C O Mitter <committer@example.com>
sub  2048g/7703B0E5 2007-06-07

pub  2048R/B7227189 2013-03-22 Eris Discordia <discord@example.net>
sub  2048R/29472784 2013-03-22
$

The patch should work as posted, though I have only tested the new 
keyring by hand as shown above.

> It feels a bit hacky, and I wish I knew more about why the current file
> doesn't work (i.e., if we did "gpg --export-secret-keys" with v1.2.6,
> would it produce different output that can be read by both versions?).

I grabbed the binary keyrings from 1e3eefb^ and pointed gpg 1.2.6 at them.

$ gpg --homedir "$GNUPGHOME" --armor --export-secret-keys CDDE430D  > 
CDDE430D.secret.key
$ gpg --homedir "$PWD/gpghome3" --import CDDE430D.secret.key
gpg: keyring `/home/tgc/gpghome3/secring.gpg' created
gpg: keyring `/home/tgc/gpghome3/pubring.gpg' created
gpg: key CDDE430D: secret key imported
gpg: Total number processed: 1
gpg:       secret keys read: 1
gpg:   secret keys imported: 1
$ gpg --homedir "$PWD/gpghome3" --list-keys
$

No public key imported however the pubkey *was* exported to 
CDDE430D.secret.key

Importing that same keyfile using gnupg 1.4.5 on an RHEL5 host:
$ gpg --homedir "$PWD/gpghome" --import /tmp/CDDE430D.secret.key
gpg: keyring `/home/tgc/gpghome/secring.gpg' created
gpg: keyring `/home/tgc/gpghome/pubring.gpg' created
gpg: key CDDE430D: secret key imported
gpg: /home/tgc/gpghome/trustdb.gpg: trustdb created
gpg: key CDDE430D: public key "C O Mitter <committer@example.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1
gpg:       secret keys read: 1
gpg:   secret keys imported: 1
$ gpg --homedir "/home/tgc/gpghome" --list-keys
/home/tgc/gpghome/pubring.gpg
-----------------------------
pub   1024D/CDDE430D 2007-06-07
uid                  C O Mitter <committer@example.com>
sub   2048g/7703B0E5 2007-06-07
$

So gnupg 1.2.6 can export fine but cannot correctly import the same.

> Another option is to just declare that version old and broken, and skip
> the tests (either by checking its version, or just checking after we
> import the keys that we can actually _use_ them).
>
That would seem a bit heavy-handed as it is otherwise working fine with 
the old gnupg.

<snip patch>

-tgc


-- 
Tom G. Christensen - Systemmedarbejder - IT-drift
Statsbiblioteket - Victor Albecks Vej 1 - 8000 Aarhus C
Tlf: (+45) 8946 2027 - Fax: (+45) 8946 2029
CVR/SE: 10100682 - EAN: 5798000791084
