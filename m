From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Add persistent-https to contrib
Date: Thu, 24 May 2012 12:33:08 -0700
Message-ID: <CAJo=hJt=q-ZnLrqzcfGrKNcao2MPDSRt3Y_r2OOfu75++N+3zw@mail.gmail.com>
References: <1337792767-18914-1-git-send-email-cranger@google.com> <7v62blxx2m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Colby Ranger <cranger@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 21:33:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXdn5-0005fL-GT
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 21:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab2EXTda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 15:33:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36885 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab2EXTd3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 15:33:29 -0400
Received: by dady13 with SMTP id y13so178439dad.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=w5DXG16WgJ5jIg8RZB8HHhrrpeG5sboGNrml+0xqB1U=;
        b=ZNY9ytvbciO8l4wUUgea8QLt7C3h5HIH12S6u6Yn3cjS4B4sbeq0X9l3BkqNLbdofY
         Xfp+lPYaClmkVd6JXlcLoZaCo41cE6+xuqXrd0+l/+OHQt9w2bJD5SkPxuNnRNCMiET8
         fDZrz0MsNmhC6G+3mBSAsl7+X26UOAGYFKFUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=w5DXG16WgJ5jIg8RZB8HHhrrpeG5sboGNrml+0xqB1U=;
        b=Yu6iWQ41ttMxA8r/el0Q39e6m0PrOjwLi22G932O+Eh/CyJ7AwEHRxY4m5dCYncnOH
         kjZbD+VEbSh3v3q8gjadOm8YWDe1fUtMy1hJhHr1xHmeJeJU+v1vQn0dgkFTDM1fyZ1B
         WgL+nunjsffjXg3RekglOdZ0J9U8injurEYHwzYV6APg7lT6YSw7Yo73g7YLWdxm9aAW
         5487TTr1326DlTXcNOp65lOLd7C4tJAZSCBomtAV2AmjUQH8hyXhEjB/Rv+ZPk/zulpE
         bGt+TNDtrcWcqXtrRMsnjVlTp8TEBQ0laRPsKCm4jfazvJRDPwOIpj62GRiVFKUJinjB
         /Qmg==
Received: by 10.68.232.161 with SMTP id tp1mr24464663pbc.44.1337888008573;
 Thu, 24 May 2012 12:33:28 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Thu, 24 May 2012 12:33:08 -0700 (PDT)
In-Reply-To: <7v62blxx2m.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkRp9Ohph8Fhuv552xEA50SZ2CMrVyDCqviTqVJ+DtJcao/8Hl1QfojuoOrvDyKqCB1GYsV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198410>

On Thu, May 24, 2012 at 11:17 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Colby Ranger <cranger@google.com> writes:
>
>> Git over HTTPS has a high request startup latency, since the SSL
>> negotiation can take up to a second. In order to reduce this latency=
,
>> connections should be left open to the Git server across requests
>> (or invocations of the git commandline).
>>
>> Reduce SSL startup latency by running a daemon job that keeps
>> connections open to a Git server. The daemon job
>> (git-remote-persistent-https--proxy) is started on the first request
>> through the client binary (git-remote-persistent-https) and remains
>> running for 24 hours after the last request, or until a new daemon
>> binary is placed in the PATH. The client determines the daemon's
>> HTTP address by communicating over a UNIX socket with the daemon.
>>>From there, the rest of the Git protocol work is delegated to the
>> "git-remote-http" binary, with the environment's http_proxy set to
>> the daemon.
>>
>> Signed-off-by: Colby Ranger <cranger@google.com>
>
> Clever. =A0Do you have some numbers?

$ (for i in {1..5}; do time git ls-remote
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
>/dev/null;done) 2>&1 | grep real
real	0m0.193s
real	0m0.175s
real	0m0.191s
real	0m0.173s
real	0m0.194s

$ (for i in {1..5}; do time git ls-remote
persistent-https://kernel.googlesource.com/pub/scm/linux/kernel/git/tor=
valds/linux
>/dev/null;done) 2>&1 | grep real
real	0m0.208s
real	0m0.085s
real	0m0.079s
real	0m0.067s
real	0m0.059s

That initial 208ms run was the local proxy starting, and the
connection being established. Its similar to the normal case.
Subsequent executions have lower latency.

> If this persistent proxy weren't in the picture, the git client would
> directly delegate its communication with the origin server to
> git-remote-https, and git-remote-https would interact with the creden=
tial
> API to handle authentication for "https://origin.server.xz/repo".

Yes.

> How does the persistent proxy sitting in between your git client and =
the
> origin server and/or the real proxy you have at the perimeter of your
> network interact with respect to authentication/authorization to acce=
ss
> the repository or the real proxy? =A0They will talk with the persiste=
nt
> proxy, and the persistent proxy will talk with the git client via
> git-remote-http, and I am assuming that this last git-remote-http wil=
l be
> the one that uses the credential API.

Yes.

> =A0Would it ask credential for
> "https://origin.server.xz/repo"? =A0"http://origin.server.xz/repo"? =A0=
Or
> would it be "persistent-https://origin.server.xz.repo"?

IIRC it asks for "http://origin.server.xz/repo".

The persistent-https code tells the git credential helper the
connection is "secure" (that is the proxy will use SSL as it exits the
local machine) by setting GIT_GOOGLE_CREDENTIAL_CORPSSO_ENABLE=3D1 in
the environment. This leaked from our internal version of the proxy,
Colby was supposed to scrub this string before open sourcing. :-)

So now everyone knows $DAYJOB =3D Google, we have a credential helper,
and it supports some sort of corporate single sign on. Whee.

>> =A0contrib/persistent-https/COPYING =A0 =A0| =A0202 ++++++++++++++++=
+++++++++++++++++++
>
> I do not mind carrying this in the contrib/ area (I am assuming that
> distributing Apache licensed software that does not link with GPLv2 c=
ore
> is OK). =A0It may be just me, but a file called COPYING that does not=
 have
> GPL text in it was a bit surprising. =A0I wonder if it is more custom=
ary to
> call it either LICENSE (or perhaps LICENSE-2.0)?

Agreed, LICENSE or LICENSE-2.0 is the right name for this file, not COP=
YING.

>> =A0contrib/persistent-https/README =A0 =A0 | =A0 62 +++++++++++
>> =A0contrib/persistent-https/client.go =A0| =A0178 ++++++++++++++++++=
++++++++++++
>> =A0contrib/persistent-https/main.go =A0 =A0| =A0 82 ++++++++++++++
>> =A0contrib/persistent-https/proxy.go =A0 | =A0190 ++++++++++++++++++=
++++++++++++++
>> =A0contrib/persistent-https/release.sh | =A0 45 ++++++++
>> =A0contrib/persistent-https/socket.go =A0| =A0 97 +++++++++++++++++
>> =A0contrib/persistent-https/tar.sh =A0 =A0 | =A0 40 +++++++
>> =A08 files changed, 896 insertions(+)
>
> It might deserve its own contrib/persistent-https/Makefile in additio=
n to
> your internal "release" scripts, though.

=46air point.
