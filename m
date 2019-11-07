Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255101F454
	for <e@80x24.org>; Thu,  7 Nov 2019 12:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbfKGMyS (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 07:54:18 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:45647 "EHLO
        smtp1.lauterbach.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfKGMyS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 07:54:18 -0500
Received: (qmail 30361 invoked by uid 484); 7 Nov 2019 12:54:15 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.10.40 by smtp1.lauterbach.com (envelope-from <ingo.rohloff@lauterbach.com>, uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.10.40):. 
 Processed in 0.548858 secs); 07 Nov 2019 12:54:15 -0000
Received: from unknown (HELO ingpc3.intern.lauterbach.com) (Authenticated_SSL:irohloff@[10.2.10.40])
          (envelope-sender <ingo.rohloff@lauterbach.com>)
          by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <gitster@pobox.com>; 7 Nov 2019 12:54:14 -0000
Date:   Thu, 7 Nov 2019 13:54:09 +0100
From:   Ingo Rohloff <ingo.rohloff@lauterbach.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: Forbid to create local branches with confusing
 names
Message-ID: <20191107135409.13fa0336@ingpc3.intern.lauterbach.com>
In-Reply-To: <xmqqftj0qkzm.fsf@gitster-ct.c.googlers.com>
References: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
        <xmqqftj0qkzm.fsf@gitster-ct.c.googlers.com>
Organization: Lauterbach GmbH
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=SHA1;
 boundary="Sig_//K30f.ks3cT3q_niAZsNzF0";
 protocol="application/pkcs7-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_//K30f.ks3cT3q_niAZsNzF0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 07 Nov 2019 15:05:49 +0900
Junio C Hamano <gitster@pobox.com> wrote:
> Ingo Rohloff <ingo.rohloff@lauterbach.com> writes:
>=20
> > ...
> > This patch forbids to create local branches, with names which start
> > with any of
> >
> >   refs/
> >   heads/
> >   remotes/
> >   tags/ =20
>=20
> Is there a reason why notes/ hierarchy is excluded?  What about
> pull/?  Are we dealing with an unbounded set?  Should this list be
> somehow end-user configurable so that say Gerrit users can add for/
> and changes/ to the "forbidden" set?

I think I did not explain the intention that well.
What I basically want to avoid is a situation in which there is
no way at all to refer unambiguously to a particular reference.

Right now this is easily possible.=20
I use the following sequence of commands to get into this
situation ("gcc_build" is just a test repository with nothing special).

  rm -rf gcc_build
  git clone ssh://ds1/home/irohloff/git/gcc_build.git
  cd gcc_build
  git checkout -b work
  echo "work..." >> 00_readme.txt
  git commit -a -m "work..."

  git branch origin/master
  git branch remotes/origin/master
  git branch refs/remotes/origin/master
  git branch -avv

The last "git branch -avv" outputs:

  master                     520d29e [refs/remotes/origin/master] initial s=
cripts for building cross compiler GCC
  origin/master              b8efa13 work...
  refs/remotes/origin/master b8efa13 work...
  remotes/origin/master      b8efa13 work...
* work                       b8efa13 work...
  remotes/origin/HEAD        -> refs/remotes/origin/master
  remotes/origin/master      520d29e initial scripts for building cross com=
piler GCC


So this already is a major confusion, because git reports there are two ref=
erences=20
with the same name "remotes/origin/master" which point to DIFFERENT objects.

What's worse: I cannot figure out a way to unambiguously refer to=20
the remote tracking branch remotes/origin/master:

git log origin/master
  warning: refname 'origin/master' is ambiguous.
  True: This refers to both
      refs/remotes/origin/master
      refs/heads/origin/master

git log remotes/origin/master
  warning: refname 'remotes/origin/master' is ambiguous.
  True: This refers to both
      refs/remotes/origin/master
      refs/heads/remotes/origin/master

git branch refs/remotes/origin/master
  warning: refname 'remotes/origin/master' is ambiguous.
  True: This refers to both
      refs/remotes/origin/master
      refs/heads/refs/remotes/origin/master

Now I have run out of ideas how to refer to the remote tracking branch.

So what I want to ensure is that there exists at least one way to=20
address a reference unambiguously.
(The SHA-1 is not really an option, because it changes each time you
update the branch head.)

I do not want to prevent people from creating ambiguities in general
or weird branch names in general, because I think that's a much harder and=
=20
maybe unsolvable problem.
I just want to make sure that there is at least one unambiguous way to=20
refer to a specific reference.

So to answer your questions:

> Is there a reason why notes/ hierarchy is excluded? =20
> What about pull/?

I basically wanted to exclude the prefixes which git auto-adds when=20
expanding reference names.

As far as I understand the source code, this means excluding the prefixes=20
which are a result of the declaration of
  ref_rev_parse_rules
So these are
  refs/
  remotes/
  tags/
  heads/
Maybe I do not really understand the source code (or my logic is bogus)
and git might somehow expand a reference abbreviation by adding=20
"notes/" or "pull/" but I do not know how to trigger this expansion.

That is my rationale behind this set of prefixes and why=20
I did not include things like "notes/", "pull/" ...

Having said this:=20
I think it might be enough to just forbid any local branch names,
which have a prefix of "refs/".
Rationale behind that:=20
I said that I want to have at least one way to unambiguously=20
refer to a reference.=20
If I forbid "refs/" as prefix, then I think in the above example,

I can always use

   git log refs/remotes/origin/master

because
   .git/refs/heads/refs/....  does not exist.

Thinking more about this:
Preventing local branches names with a "refs/" prefix=20
is just the tip of the iceberg.
Someone might use
  git tag refs/remotes/origin/master
or
  git add remote refs/remotes/origin <URL>
  git fetch refs/remotes/origin

After this refs/remotes/origin/master is again ambiguous.

> Should this list be somehow end-user configurable so that say Gerrit user=
s=20
> can add for/ and changes/ to the "forbidden" set?

This might be interesting in the future, but at least for now the goal was =
to
prevent a situation in which there is no unambiguous name at all for a refe=
rence.

So I was not thinking about a "convenience" feature for users but really pr=
eventing
to get the repository into an almost unusable state.

So to answer your question: No; right now I did not think that this should =
be=20
end-user configurable, because the set of prefixes is derived from the decl=
aration=20
of "ref_rev_parse_rules", which contains a non-configurable set of rules.



>=20
> This is not a change to builtin/branch.c, so other commands that
> call create_branch() would be affected---are they all equipped to
> toggle on the same bit that is affected by the '-f' option you have
> in mind (presumably "git branch -f")?  Wouldn't forcing for those
> other command have undesirable side effects?
>=20
> I didn't check the code, but I think "checkout -b" also calls
> create_branch() so presumably it also is affected.  Using "-B"
> instead of "-b" for "checkout" might pass the force bit on, but
> typically that is done only to recreate an existing branch.  Is it a
> good idea to change the meaning of "-B" to also mean "do not bother
> checking the sanity of the branch name"?
>=20

Yes you are completely right:=20
I was not at all sure where to put the check.
As mentioned above: If the goal is to prevent to get a git repository into
a super confusing state, then you probably also need to add constraints for
remote names and tag names.

Are there more names which are part of reference names ?

so long
  Ingo

--Sig_//K30f.ks3cT3q_niAZsNzF0
Content-Type: application/pkcs7-signature; name=smime.p7s
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAA
oIIJfzCCAy4wggKXoAMCAQICCQC7i9s9ouYFvDANBgkqhkiG9w0BAQUFADBuMQsw
CQYDVQQGEwJERTEQMA4GA1UECBMHQmF2YXJpYTEWMBQGA1UEBxMNSG9laGVua2ly
Y2hlbjEYMBYGA1UEChMPTGF1dGVyYmFjaCBHbWJIMRswGQYDVQQDExJMYXV0ZXJi
YWNoIFJPT1QgQ0EwHhcNMTAwOTIzMDgxMjE4WhcNMjAwOTIwMDgxMjE4WjBuMQsw
CQYDVQQGEwJERTEQMA4GA1UECBMHQmF2YXJpYTEWMBQGA1UEBxMNSG9laGVua2ly
Y2hlbjEYMBYGA1UEChMPTGF1dGVyYmFjaCBHbWJIMRswGQYDVQQDExJMYXV0ZXJi
YWNoIFJPT1QgQ0EwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAM39XJbdGQJl
3TdtHQMmxHCpScatBcpcWCj76UUIANzDpnNQ74GABRmKC1fKQJH+kmLdI4v48Min
Ee91Kmcq/+KFrVNPwa3bSg1DMA/oXv2X1W6WJ1ljrJfIS8Vvk6DJxO/25uR1qRrs
aq25B6bxl1Sb81lYHIsOs065bfL96Ri7AgMBAAGjgdMwgdAwHQYDVR0OBBYEFNVT
bzNAmbwF8A06hbYbgbMEv03MMIGgBgNVHSMEgZgwgZWAFNVTbzNAmbwF8A06hbYb
gbMEv03MoXKkcDBuMQswCQYDVQQGEwJERTEQMA4GA1UECBMHQmF2YXJpYTEWMBQG
A1UEBxMNSG9laGVua2lyY2hlbjEYMBYGA1UEChMPTGF1dGVyYmFjaCBHbWJIMRsw
GQYDVQQDExJMYXV0ZXJiYWNoIFJPT1QgQ0GCCQC7i9s9ouYFvDAMBgNVHRMEBTAD
AQH/MA0GCSqGSIb3DQEBBQUAA4GBAFZdiH817ql21GVWK4H3zCVWqFzm+TeHeZP1
lyApr2HAzt/cAUdbElkIN4E7xVlZDvMfJNu6mijJ4YEWYpDMC7vIFa7f9qvZTq7I
yoDV7AzsLCn/sN1JULgP3n14coFVdjRd4FzKHrn0OqtCYyn3rhiyYnxyBGyROhg+
IbageRWGMIIDDjCCAnegAwIBAgIBAjANBgkqhkiG9w0BAQUFADBuMQswCQYDVQQG
EwJERTEQMA4GA1UECBMHQmF2YXJpYTEWMBQGA1UEBxMNSG9laGVua2lyY2hlbjEY
MBYGA1UEChMPTGF1dGVyYmFjaCBHbWJIMRswGQYDVQQDExJMYXV0ZXJiYWNoIFJP
T1QgQ0EwHhcNMTAxMDE0MTMzNzQ3WhcNMjAxMDExMTMzNzQ3WjBWMQswCQYDVQQG
EwJERTEQMA4GA1UECBMHQmF2YXJpYTEYMBYGA1UEChMPTGF1dGVyYmFjaCBHbWJI
MRswGQYDVQQDExJMYXV0ZXJiYWNoIE1BSUwgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBANM42fuvAjUafxjRsv/bMV6BGD6FCSJGGPbFgChQFt+wHI9YNjnN
KqY7Y0hN7XI4UnsrpuiJh63tbHIeUsLjXFVfY24lcdrG7R329Li8jrD3e/6B7dAV
D+NNc6vtgauhpmMDIrWCDEXL76vqEN+log48hBGKbWo/hmEyFrg138PnAgMBAAGj
gdMwgdAwHQYDVR0OBBYEFH2AXQNSUKF//sgfLsDfzWXsj4+FMIGgBgNVHSMEgZgw
gZWAFNVTbzNAmbwF8A06hbYbgbMEv03MoXKkcDBuMQswCQYDVQQGEwJERTEQMA4G
A1UECBMHQmF2YXJpYTEWMBQGA1UEBxMNSG9laGVua2lyY2hlbjEYMBYGA1UEChMP
TGF1dGVyYmFjaCBHbWJIMRswGQYDVQQDExJMYXV0ZXJiYWNoIFJPT1QgQ0GCCQC7
i9s9ouYFvDAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBBQUAA4GBAJhFv6p30xOG
TYViB4yReLjUu5aGagcha/+03xlnNA/iw5Sb0vG8QR4H3FHWjWXh8DdgPCUPBgV0
HLtfkMiJZ2Wka94MOVI7G8wV/QN9BShBald7kiRryn6+TJDrvA5lZwUO4FrRB5/w
18rSTckil+Z3qSUKaB4xdgFlWdwdxj4rMIIDNzCCAqCgAwIBAgIBfjANBgkqhkiG
9w0BAQUFADBWMQswCQYDVQQGEwJERTEQMA4GA1UECBMHQmF2YXJpYTEYMBYGA1UE
ChMPTGF1dGVyYmFjaCBHbWJIMRswGQYDVQQDExJMYXV0ZXJiYWNoIE1BSUwgQ0Ew
HhcNMTgxMDIzMTIyNjQwWhcNMjAxMDIyMTIyNjQwWjB3MQswCQYDVQQGEwJERTEL
MAkGA1UECBMCQlkxGDAWBgNVBAoTD0xhdXRlcmJhY2ggR21iSDEVMBMGA1UEAxMM
SW5nbyBSb2hsb2ZmMSowKAYJKoZIhvcNAQkBFhtpbmdvLnJvaGxvZmZAbGF1dGVy
YmFjaC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCgc+QXSXYX
5OPIzOiBGQ3yTbt6CBNRyhx/rmSIEG3Oixn3rsmMWJ9BccSn7yNjbiqRK5cTg0VA
b9DRQ+lEzQtRanNgXBndsMrK7fFsrh1AXGLVxElC8cqigIpZDntbSNqVzZ0x6UiI
0XNZd8rgKaOBBf2r1qtShqzeU7lX+hkM+FAlB6JcuK3I1hHQgg+YK7BB2TxADecm
/2Ln73Bsstscw/z6OJasHcdsWbbwRuZWnZVlqcwEXW3nxjrMF0qzSSlWAHvHz1j3
Srwu4xWzZXODCwzEe84FRLvD9QZhqDGPbohLdf+HE7mP5fOkaUqhnO5AJdtDK3wo
elfF+l1HVnpvAgMBAAGjcDBuMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVy
YXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQUMldvhzNlApt/EKN8lc3lhJfmuqMw
HwYDVR0jBBgwFoAUfYBdA1JQoX/+yB8uwN/NZeyPj4UwDQYJKoZIhvcNAQEFBQAD
gYEAmWL6vS2JLNj/GvctOT9utqVG8u+h0CVZfe480vkVMFVTKNuNAZ11ilJAdf+8
LbWq/zEr+eatTZBY5Ai1aJE91gl13B39LjjOt/PIw5+CUFzK+yM7V/x+XoxHca+U
5TJW/KA6MLdxBxonJx25imcpP1NwjB3zCIiTN4+Q87RFXQ8xggIMMIICCAIBATBb
MFYxCzAJBgNVBAYTAkRFMRAwDgYDVQQIEwdCYXZhcmlhMRgwFgYDVQQKEw9MYXV0
ZXJiYWNoIEdtYkgxGzAZBgNVBAMTEkxhdXRlcmJhY2ggTUFJTCBDQQIBfjAJBgUr
DgMCGgUAoIGHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE5MTEwNzEyNTQwOVowIwYJKoZIhvcNAQkEMRYEFGVnqRfV8GEUYOHcjgjY
Z/P3v4UKMCgGCSqGSIb3DQEJDzEbMBkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMH
MA0GCSqGSIb3DQEBAQUABIIBAJ5bVluxv757fCAWEvYYJuNQexhK/SCGdNq7a7MU
Rm7UhXJFvTOJQOaEQm7274pCDdw5IKhcSg18qtlCLmsXjB4s8ksNX7In8VJ6hjIG
oWbSXEGeek5KiSeN16PCWLvrLZoucQ80WqtROYckJ15debrv8I9oHPM4Hf1OcKLw
0Abf6/yWvOm8Ddg5XRgrbfF8/hT+I1Jp11hk7EtpbMzBpTQFEDN4iepvLQjCYXEi
EBU2Hop1BsLYJK3cCSKndpG3vlJy16XjcgF1lNSS77fhJJU+6peWGtASBMXOrtBo
AEQy1iaR1fitbyEGei9ZfShiICgZpQZuuToKM8x8SMw0ZaIAAAAAAAA=

--Sig_//K30f.ks3cT3q_niAZsNzF0--
