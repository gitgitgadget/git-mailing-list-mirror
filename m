Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DB61F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 23:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbcJKXc4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 19:32:56 -0400
Received: from tc.outersquare.org ([75.144.255.93]:41243 "EHLO
        cid.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbcJKXcz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 19:32:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by cid.outersquare.org (Postfix) with ESMTP id EA9AA67C0EF4;
        Tue, 11 Oct 2016 16:32:53 -0700 (PDT)
X-Virus-Scanned: amavisd-new at mydomain = outersquare.org
Received: from cid.outersquare.org ([127.0.0.1])
        by localhost (cid.outersquare.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Py0zdmFzKDyr; Tue, 11 Oct 2016 16:32:52 -0700 (PDT)
Received: from [17.212.151.100] (unknown [17.212.151.100])
        by cid.outersquare.org (Postfix) with ESMTPSA id EBA1167C0EDB;
        Tue, 11 Oct 2016 16:32:51 -0700 (PDT)
From:   Jeremy Huddleston Sequoia <jeremyhu@freedesktop.org>
Message-Id: <EF7F9B45-867A-433B-9623-EBBF33D34793@freedesktop.org>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3B41A410-82B6-4D5B-99B1-B414317AC753";
 protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3249\))
Subject: Re: git 2.10.1 test regression in t3700-add.sh
Date:   Tue, 11 Oct 2016 16:32:51 -0700
In-Reply-To: <xmqq8ttwgkyo.fsf@gitster.mtv.corp.google.com>
Cc:     t.gummerer@gmail.com, git@vger.kernel.org
To:     Junio C Hamano <gitster@pobox.com>
References: <A433322C-2B75-4B4B-A8CC-BAC3179EE7A7@freedesktop.org>
 <98EB348E-221D-488C-A466-1FACB1C768FF@freedesktop.org>
 <6CA5F44F-38C1-4C15-9B85-FE84FB93E616@freedesktop.org>
 <49BF26B2-8E6D-40B1-87A2-1FDDF9A76B8E@freedesktop.org>
 <xmqq8ttwgkyo.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3249)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_3B41A410-82B6-4D5B-99B1-B414317AC753
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Oct 10, 2016, at 10:41, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Jeremy Huddleston Sequoia <jeremyhu@freedesktop.org> writes:
>=20
>> Actually, looks like that as just a rabbit hole.  The real issue
>> looks to be because an earlier test drops down xfoo3 as a symlink,
>> which causes this test to fail due to the collision.  I'll get out
>> a patch in a bit.
>=20
> [administrivia: please don't top-post, it is extremely hard to
> follow what is going on]
>=20
> There indeed is a test that creates xfoo3 as a symbolic link and
> leaves it in the filesystem pointing at xfoo2 much earlier in the
> sequence.  It seems that later one of the "add ignore-errors" tests
> (there are two back-to-back) runs "git reset --hard" to make it (and
> other symbolic links that are similarly named) go away, namely this
> part of the code:
>=20
>    test_expect_success POSIXPERM,SANITY 'git add --ignore-errors' '
>            git reset --hard &&
>            date >foo1 &&
>            date >foo2 &&
>            chmod 0 foo2 &&
>            test_must_fail git add --verbose --ignore-errors . &&
>            git ls-files foo1 | grep foo1
>    '
>=20
>    rm -f foo2
>=20
>    test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors)' =
'
>            git config add.ignore-errors 1 &&
>            git reset --hard &&
>            date >foo1 &&
>            date >foo2 &&
>            chmod 0 foo2 &&
>            test_must_fail git add --verbose . &&
>            git ls-files foo1 | grep foo1
>    '
>    rm -f foo2
>=20
> "git reset --hard" in the first one, because these symbolic links
> are not in the index at that point in the sequence, would leave them
> untracked and in the working tree.  Then "add" is told to be
> non-atomic with "--ignore-errors", adding them to the index while
> reporting a failure.  When the test after that runs "git reset --hard"
> again, because these symlinks are in the index (and not in HEAD),
> they are removed from the working tree.
>=20
> And that is why normal people won't see xfoo3 in later tests, like
> the one you had trouble with.
>=20
> Are you running without SANITY by any chance (I am not saying that
> you are doing a wrong thing--just trying to make sure I am guessing
> along the correct route)?

Ah, yep.  That's the ticket:

ok 23 # skip git add should fail atomically upon an unreadable file =
(missing SANITY of POSIXPERM,SANITY)
ok 24 # skip git add --ignore-errors (missing SANITY of =
POSIXPERM,SANITY)
ok 25 # skip git add (add.ignore-errors) (missing SANITY of =
POSIXPERM,SANITY)
ok 26 # skip git add (add.ignore-errors =3D false) (missing SANITY of =
POSIXPERM,SANITY)
ok 27 # skip --no-ignore-errors overrides config (missing SANITY of =
POSIXPERM,SANITY)

I dug into it a bit, and since I'm running the tests during a staging =
phase which runs as root, !SANITY gets set.  Should be solvable by =
essentially breaking test out into post-build instead of pre-install.  =
Thanks for the pointer there.


> If that is the issue, then I think the right correction would be to
> make sure that the files that an individual test expects to be
> missing from the file system is indeed missing by explicitly
> removing it, perhaps like this.
>=20
> I also notice that the problematic test uses "chmod 755"; don't we
> need POSIXPERM prerequisite on this test, too, I wonder?
>=20
> Thanks.
>=20
> -- >8 --
> t3700: fix broken test under !SANITY
>=20
> An "add --chmod=3D+x" test recently added by 610d55af0f ("add: modify
> already added files when --chmod is given", 2016-09-14) used "xfoo3"
> as a test file.  The paths xfoo[1-3] were used by earlier tests for
> symbolic links but they were expected to have been removed by the
> test script reached this new test.
>=20
> The removal with "git reset --hard" however happened in tests that
> are protected by POSIXPERM,SANITY prerequisites.  Platforms and test
> environments that lacked these would have seen xfoo3 as a leftover
> symbolic link, pointing somewhere else, and chmod test would have
> given a wrong result.
>=20
>=20
>=20
> t/t3700-add.sh | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 924a266126..53c0cb6dea 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -350,6 +350,7 @@ test_expect_success POSIXPERM,SYMLINKS 'git add =
--chmod=3D+x with symlinks' '
> '
>=20
> test_expect_success 'git add --chmod=3D[+-]x changes index with =
already added file' '
> +	rm -f foo3 xfoo3 &&
> 	echo foo >foo3 &&
> 	git add foo3 &&
> 	git add --chmod=3D+x foo3 &&


I actually tried that, but the problem is that xfoo3 was previously =
added as a symlink, so test_mode_in_index still reports it as a symlink.

It's fundamentally a question of who is responsible for cleanup.  Is the =
individual test responsible for cleaning up after itself (such that =
later tests can rely on a clean state), or should individual tests =
assume that the initial state might be undefined and try to cleanup =
after earlier tests?  I'm in favor of either doing the former or =
ensuring that tests don't step on each-others toes.

--Jeremy


--Apple-Mail=_3B41A410-82B6-4D5B-99B1-B414317AC753
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIM5TCCBeIw
ggPKoAMCAQICEFy2SG5HDJjGf/aA22RK4o0wDQYJKoZIhvcNAQELBQAwfTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmlj
YXRlIFNpZ25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4X
DTE1MTIxNjAxMDAwNVoXDTMwMTIxNjAxMDAwNVowdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAO4PUIyVCSOErPVQao/WN6JOIf0yCWVHPq84+tUb94TQf8nhBAtX894vxFPjFzjh
sTOygm7QiHCcRyFv5PET+rDzzDuHE4O7Dc3wVrGLHprWOnzf5Fa9kdl/vz477cZgGl6Rl9M570D8
WhNdtyDBl8tMxCh2f5yQ2dffUz/UzZ/b/tUDtAGW+KGie3IdA6UiWvJBecYjRQwIPbWiikq1bjxy
S/TBRWDyKsEoYx4PrmBM438WzD9kFsGpp2gPWO3zkUgzWqXbhZQEQHA7V3TKQIo4huByp6zd9tyN
Cmu5Q0wFsi7UwwhEyrCPH8zsi9IpxLtVhFaXT8rZvLNa8EAeH/UCAwEAAaOCAWQwggFgMA4GA1Ud
DwEB/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB
/wIBADAyBgNVHR8EKzApMCegJaAjhiFodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmww
ZgYIKwYBBQUHAQEEWjBYMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5zdGFydHNzbC5jb20wMAYI
KwYBBQUHMAKGJGh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL2NhLmNydDAdBgNVHQ4EFgQU
mZerGDU6i1lFQ5iycnHI9PsJzxYwHwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwPwYD
VR0gBDgwNjA0BgRVHSAAMCwwKgYIKwYBBQUHAgEWHmh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3Bv
bGljeTANBgkqhkiG9w0BAQsFAAOCAgEAmUFBBM72JPVOMDR4Q7tX/UBsG8wB+JuMCCh/GYnTWMGY
cqDSltONYidNNijFvcsGDPeZ+O+9LU+Och9vb0zJWbQb89IeOCrsTCzV0Qkw8L1dO7E9/Zz4xYuT
KcGWi1bnjYmmtb6JNZ9lp/JS3MgpbWGTRgBInzNJKPwP773JH7RSGRu+UQImR2LX563QRojschfp
xyPWt9wUV+VZf989Prh2f2OmD2zSe4m6DhaxWQQrbfpad1mgwetmaAXsIjJndPSa6pjCQBIMNxG3
0DbWj8xz4PxDoZWYpEYHeAQq862yKgdkSom/oJ0CbdrqCWijmlfdEvV4LNzwvN+zhPQhJmOvzE0x
tMaWy4doUf6y0N7Aqx+emjg3rg60AavOZV8UWwwhEQ1EexWVIR7/otWkGmOfTT7tuoQ3ep6pLEg6
tpgnXaYnTwbhic/ZTV9p0chpLnQ7lleoCK+gGX2mL/oIE1znAgyWRczIVnSwuwj70SsUO704mFfu
JYKjr1fTJ2XNePTz7YrU8rKv6Dr+9M8e6vrcmi02uHKhYQnJYSMEsDhCYld8akHm75sLA1+wWlxg
CWSIW3VGza96aBIHLergMcNs8q+vVgiZk1FIc/5Nf00/3glGSapzIP+po3u7YlXWlECXAbSenKuf
plAzVAdX6IVvBDhWosxaT/9BWj+tnLUwggb7MIIF46ADAgECAhAX8MOmbUCDPWU+X4TKPzSUMA0G
CSqGSIb3DQEBCwUAMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYD
VQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20g
Q2xhc3MgMiBDbGllbnQgQ0EwHhcNMTYwMTI4MDUzNDA3WhcNMTgwMTI4MDUzNDA3WjBzMQswCQYD
VQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTERMA8GA1UEBwwIV29vZHNpZGUxGTAXBgNVBAMM
EEplcmVtaWFoIFNlcXVvaWExITAfBgkqhkiG9w0BCQEWEmplcmVteWh1QGdtYWlsLmNvbTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANJQpjXCVgn9Bf+x34nMseNlpLX3qKn9mGqv2uh2
gBPf++z3kXVI2c92FN/lEicsvvAnuo3q0RwJvh/Z++8dW+RRuAm58adZmXEJWwf90vLzH3hFDC4W
V6slcg3e5KvtcJ+u6BzT/WFRdDGEPqsYENI0OpEJK2NcfmRzkZ+CTitMp379Z7vV3ly3l72Y/I4E
UZgYSluez4qqwlljdOVgL7aTmrJuw2ZI5CoDpj2xiwvFxFm9vyfgyyh34p2sFhSR/AWZR5rsfyoM
fw0uJ7s7a5EgdOf/dS0eeqpohBAXvfHQ0AFq4Gx++bAxWCaogskAhTxGBoc9fn85CCyiwlrfNcZZ
6+L5rY+n7JoUHRYZjwYIBieI5YQ247GkN8R+fBjIrMCDl/+7uI/1Vg/hxstsrvUyLouuOl9k3WWu
PSiSHjKZGuNnZS4z1LXDBnOtUCsyjHs79L617AyFK3Mt+W5qdUK5ChPzNYL5IcNLkkLduy6WGsZH
39n9Lruemd6qr+T9Syd1x+Zz7+4xog6DFyML89nJT7mQ1MDUVEpyX2N1GvDCgnVJ7iOQB1mL7fKg
qEdLYkihyWy3SkJrmw/Ga+GOjr0DkmrUUWIYkAOF8mWKGoigayR3RMZhWDyRxpXyFF7jtphX9Fob
Td96tP4RWs9GrfD5BGVtdhVW97SW0A3D8UkxAgMBAAGjggKHMIICgzALBgNVHQ8EBAMCBLAwHQYD
VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0OBBYEFMXHiWE0gVse
XU627q/t4qVnbDu6MB8GA1UdIwQYMBaAFJmXqxg1OotZRUOYsnJxyPT7Cc8WMG8GCCsGAQUFBwEB
BGMwYTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDkGCCsGAQUFBzAChi1o
dHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50Mi5jcnQwOAYDVR0fBDEwLzAt
oCugKYYnaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDIuY3JsMIHjBgNVHREEgdsw
gdiBEmplcmVteWh1QGdtYWlsLmNvbYESamVyZW15aHVAYXBwbGUuY29tgRFqZXJlbXlodWRAbWFj
LmNvbYEVamVyZW15aHVAbWFjcG9ydHMub3JngRhqZXJlbXlodUBmcmVlZGVza3RvcC5vcmeBEGpl
cmVteWh1ZEBtZS5jb22BFGplcmVteWh1ZEBpY2xvdWQuY29tgRRqZXJlbXlAamVyZW15aHUuaW5m
b4EUamVyZW15QGh1ZHNjYWJpbi5jb22BFmplcmVteUBvdXRlcnNxdWFyZS5vcmcwIwYDVR0SBBww
GoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMFQGA1UdIARNMEswDAYKKwYBBAGBtTcGATA7Bgsr
BgEEAYG1NwECBDAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kw
DQYJKoZIhvcNAQELBQADggEBANa+oip18OvH6LflykKaMt8qN07CwhNKYvWcCeTCR2IDJsDUbVXB
9H8RqqAgEs7pEjRY+gdJSzf8wqPzJ5n6zpyeJH7p1Rsvdx9UEknqgJlmKjzOJ15GFWMjhWjlg05n
SKJsGmJrpIHVjxSeq+q5RVizyxYh1OyRisKmSrJdrmqHeBcKjlfQjFtdEt/LZrJ/qzH4WaRohdoN
C5vXwIxdczlEnZc1+ZfM5j39unU1GAskIgQCHrUJcublS53ysYKo6JhidGUytVB5O0k6J1J73dCZ
DOhlN/np0KmCWDYx8UgdJHhEyhyAKSWWltf2U4bPpEI4BbOKwegeRJJqK1oRW9cxggROMIIESgIB
ATCBiTB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UECxMgU3Rh
cnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENsYXNzIDIg
Q2xpZW50IENBAhAX8MOmbUCDPWU+X4TKPzSUMAkGBSsOAwIaBQCgggGZMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2MTAxMTIzMzI1MVowIwYJKoZIhvcNAQkEMRYE
FEhSHdw3RbY9bC3OkKK6cVWtbPkEMIGaBgkrBgEEAYI3EAQxgYwwgYkwdTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24g
QXV0aG9yaXR5MSMwIQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1l
Pl+Eyj80lDCBnAYLKoZIhvcNAQkQAgsxgYyggYkwdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1lPl+Eyj80lDANBgkq
hkiG9w0BAQEFAASCAgAFVVJ8NhSxX3KPOuk3L+6iXIt4OHEb85ACjaqGQwH6aKHKgPyZyetWtKoT
nlBWM7tW/XMWmGvGnIIYZccitwootBY1Y0Wm2YPAGfAF814oyAYGIz/FWbziZgJM7sCCtQECeJNp
9ibfG+Fj27EnEVupiWL8JQxA3qgHFwDtPaVdrt/0wFhfYrSJm6k63ECKJUXvRCeNiOi/AlLCyHaG
5bou9dJ9YFqxBzLuVxJtfFQt/t/GFUQGzNbPEhw1TlNcPVtxw6VecGl1kTl8VxlI7hkFnmq16dzU
t7YwGHp4czq56eLq7an8ZPSfwqjm4tgLmfmMW7Cs4RsENk/GVTkhjaYzet2EoY9ivsbskXmFmLM1
Wnzay5fYbwsurdjKP/zNGBp993vsyRWc/zvC5sB7q4Nha00QMNjRqVZWLgbni99TC8inESdwwh6M
8j/Dgm4wSsYEZQoO2PUcBz14RJPxfKWRsAGTCElnRZ00mNYjX9uBZflUKE7vQd7Hbr1nlpqNibkY
9kEbwDLxE5QUl4x0KKBsZQxbCK9PxOUyaWUxlLBY9jtcgW44PzIi9eoNjhHMtObwP2K5ezisDhCe
wGPdMMUFGzow9kWLu39Cn1x4GLhZ4XPmuxOF8sIUHk1PNkJ1Fksc2uVIfbmMcydHNH+BQePVXtRi
en3shoifQaHB7he4KAAAAAAAAA==
--Apple-Mail=_3B41A410-82B6-4D5B-99B1-B414317AC753--
