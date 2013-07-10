From: Friedrich Delgado <delgado@dfn-cert.de>
Subject: segmentation fault after successful completion of certain git svn
 commands
Date: Wed, 10 Jul 2013 12:51:16 +0200
Organization: DFN-CERT Services GmbH
Message-ID: <20130710105116.GA31645@rosita.dfn-cert.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1;
	protocol="application/pkcs7-signature"; boundary="17pEHd4RhPHOinZp"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 13:00:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uws82-000121-PR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab3GJLAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:00:04 -0400
Received: from sam.dfn-cert.de ([193.174.13.196]:52346 "EHLO sam.dfn-cert.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab3GJLAD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:00:03 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2013 07:00:02 EDT
Received: by rosita.dfn-cert.de (Postfix, from userid 565)
	id 82BEC5EE4A; Wed, 10 Jul 2013 12:51:16 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230038>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I suspect I may have found a problem in the way git-svn uses SVN::Core
that leads to a segmentation fault. That's a hypothesis based on the
following incomplete findings:

git version 1.8.3.2.50.g531c8dd      (from recent git maint)
svn, version 1.7.10 (r1485443)       (from openSUSE 12.2)
subversion-perl-1.7.10-4.16.1.x86_64 (from openSUSE 12.2)

,----[ ~/.subversion/config ]
  [auth]
  password-stores =3D kwallet
  store-passwords =3D yes
  store-ssl-client-cert-pp =3D yes
`----

~/.subversion/servers is set up to use a pkcs12 certificate for
certain projects.

Unfortunately I'm not the administrator of the box, so I'd have to ask
the system administrator to install the debug packages for me if you
need a useful gdb backtrace. Maybe the following information helps, if
not, I'll see what I can do to provide a meaningful gdb backtrace.

In a git-svn checkout of such a project:

,----[ redacted ]
  > perl -d:Trace ~/anon-vc/git/git-svn rebase 2>&1|tail
  >> /usr/lib/perl5/5.16.0/File/Temp.pm:895:                   @{ $dirs_to_=
unlink{$$} } : () );
  >> /usr/lib/perl5/5.16.0/File/Temp.pm:896:       foreach my $dir (@dirs) {
  >> /usr/lib/perl5/5.16.0/File/Temp.pm:908:       @{ $files_to_unlink{$$} =
} =3D ()
  >> /usr/lib/perl5/5.16.0/File/Temp.pm:910:       @{ $dirs_to_unlink{$$} }=
 =3D ()
  >> /home/user/local/stow/git/lib/perl5/site_perl/5.16.0/Git/SVN.pm:1659: =
    unmemoize_svn_mergeinfo_functions();
  >> /home/user/local/stow/git/lib/perl5/site_perl/5.16.0/Git/SVN.pm:1626: =
            return if not $memoized;
  >> /home/user/local/stow/git/lib/perl5/site_perl/5.16.0/Git/SVN.pm:85:   =
    unlink keys %LOCKFILES if %LOCKFILES;
  >> /home/user/local/stow/git/lib/perl5/site_perl/5.16.0/Git/SVN.pm:86:   =
    unlink keys %INDEX_FILES if %INDEX_FILES;
  >> /usr/lib/perl5/vendor_perl/5.16.0/x86_64-linux-thread-multi/SVN/Core.p=
m:390:     $globaldestroy =3D 1;
  >> /usr/lib/perl5/vendor_perl/5.16.0/x86_64-linux-thread-multi/SVN/Core.p=
m:58:     SVN::_Core::apr_terminate();
  [1]    1631 segmentation fault (core dumped)  perl -d:Trace ~/anon-vc/git=
/git-svn rebase 2>&1 |=20
         1632 done                              tail
`----

(The segfault will also occur after git svn clone.)

It appears that rebase and clone lead to correct results. An strace
seems to indicate that the segfault occurs after a munmap.

,----[ redacted ]
  > strace -f git svn rebase 2>&1|tail -20
  [pid  2355] rt_sigaction(SIGRT_32, NULL, {SIG_DFL, [], 0}, 8) =3D 0
  [pid  2355] rt_sigaction(SIGABRT, NULL, {SIG_DFL, [], 0}, 8) =3D 0
  [pid  2355] rt_sigaction(SIGCHLD, NULL, {0x7ff0c737d250, [], SA_RESTORER|=
SA_NOCLDSTOP, 0x7ff0d00a1140}, 8) =3D 0
  [pid  2355] rt_sigaction(SIGIO, NULL, {SIG_DFL, [], 0}, 8) =3D 0
  [pid  2355] rt_sigaction(SIGSYS, NULL, {SIG_DFL, [], 0}, 8) =3D 0
  [pid  2355] futex(0x7ff0ca0372c0, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
  [pid  2355] futex(0x7ff0ca037280, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
  [pid  2355] futex(0x7ff0cab9a0a0, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
  [pid  2355] write(6, "XXXIXTAMPEREDXWITHXTHISXSTRINGXXXXXXX"..., 37) =3D =
37
  [pid  2355] brk(0x30f7000)              =3D 0x30f7000
  [pid  2355] close(6)                    =3D 0
  [pid  2355] munmap(0x7ff0c7940000, 2113920) =3D 0
  [pid  2355] --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSEGV_MAPERR, si_ad=
dr=3D0x7ff0c7941df0} ---
  [pid  2355] +++ killed by SIGSEGV (core dumped) +++
  <... wait4 resumed> [{WIFSIGNALED(s) && WTERMSIG(s) =3D=3D SIGSEGV && WCO=
REDUMP(s)}], 0, NULL) =3D 2355
  --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_DUMPED, si_pid=3D2355, si_=
status=3DSIGSEGV, si_utime=3D22, si_stime=3D95} ---
  write(2, "error: git-svn died of signal 11"..., 33error: git-svn died of =
signal 11
  ) =3D 33
  exit_group(139)                         =3D ?
  +++ exited with 139 +++
`----

(both traces were edited a bit by me)

Maybe the following two urls I found are related or helpful:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D551769
http://subversion.tigris.org/ds/viewMessage.do?dsForumId=3D1065&dsMessageId=
=3D2356032

That's all I can think of right now. Please tell me if there's any
more information I should provide to help you narrow this down.

Thanks in advance and kind regards
       Friedrich Delgado
--=20
Dipl.-Inform Friedrich Delgado             (Projekt- und Entwicklungsteam)

DFN-CERT Services GmbH, https://www.dfn-cert.de/
Sitz/Register: Hamburg,  AG Hamburg,  HRB 88805,  Ust-IdNr.: DE 232129737
Sachsenstra=DFe 5, 20097 Hamburg/Germany,  CEO: Dr. Klaus-Peter Kossakowski

--17pEHd4RhPHOinZp
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISQTCC
A58wggKHoAMCAQICASYwDQYJKoZIhvcNAQEFBQAwcTELMAkGA1UEBhMCREUxHDAaBgNVBAoT
E0RldXRzY2hlIFRlbGVrb20gQUcxHzAdBgNVBAsTFlQtVGVsZVNlYyBUcnVzdCBDZW50ZXIx
IzAhBgNVBAMTGkRldXRzY2hlIFRlbGVrb20gUm9vdCBDQSAyMB4XDTk5MDcwOTEyMTEwMFoX
DTE5MDcwOTIzNTkwMFowcTELMAkGA1UEBhMCREUxHDAaBgNVBAoTE0RldXRzY2hlIFRlbGVr
b20gQUcxHzAdBgNVBAsTFlQtVGVsZVNlYyBUcnVzdCBDZW50ZXIxIzAhBgNVBAMTGkRldXRz
Y2hlIFRlbGVrb20gUm9vdCBDQSAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
qwujNeCLKRSxFIWvPBDkOW81XUqu3ephjZVJ9G9koxpgZqSpQCKE2dSl5XiTDmgBrblNXDrO
07ioQkDfz6O6gllqkhusHJraCCslJ/lpI0fx4Ossepv1EwLQfjR8wp48AFmr9doM9TI8K6xQ
2tbD3oOUyqgMmTIOCEhWW2r72uFYWAFJX3JBPBUGAY5draq4k7TNnuun6GotUjTbOu9cdVHa
2/Mx+e5xmDLEVBVEDPmbVe2t3xgIoKOGiknuUwWPGUzV3lh5m9JqHEKrxdWnz2gPluThYZh2
YciRfNY+AOKRUIfhnQrmrZfSHcY6fcu82gM01Y5bAfVqB7cWtm5KfwIDAQABo0IwQDAdBgNV
HQ4EFgQUMcN5G7r1U9cX4Il6LRdsCrMrnTMwDwYDVR0TBAgwBgEB/wIBBTAOBgNVHQ8BAf8E
BAMCAQYwDQYJKoZIhvcNAQEFBQADggEBAJRkWa05ZOcp6xP+WsOLE1fIBCTwdHfAYONn++mJ
poO/loJ8btTDPe+egG67KbSYerE7VOs5F0d+Go4L/B8xWTEEss4X8yzHYjZV4iLYiVW0mEiq
ZPrWHDbYRHhaWiM6V5f1ejBPrp9qTEsrjqAD4z7gqdTSe9KzqOJyPK2e/4BZ5JtFtPY7sM05
GZgy5eohYZDkMSGONLH3LzVKhRDa54o3Ib5ZY+DyhYgxU9RUFIVwefQuBncndS8fuIr5/sW6
2Dbkg+znZbe/Y1rzRq+BlDfUQYzWI9Yez/VoG0Rjolq6pzVZoeVwBZsOI1eZlAptujljKIaS
8xiE2PvRzwVWZFcwggQhMIIDCaADAgECAgIAxzANBgkqhkiG9w0BAQUFADBxMQswCQYDVQQG
EwJERTEcMBoGA1UEChMTRGV1dHNjaGUgVGVsZWtvbSBBRzEfMB0GA1UECxMWVC1UZWxlU2Vj
IFRydXN0IENlbnRlcjEjMCEGA1UEAxMaRGV1dHNjaGUgVGVsZWtvbSBSb290IENBIDIwHhcN
MDYxMjE5MTAyOTAwWhcNMTkwNjMwMjM1OTAwWjBaMQswCQYDVQQGEwJERTETMBEGA1UEChMK
REZOLVZlcmVpbjEQMA4GA1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0Eg
R2xvYmFsIC0gRzAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6ZvDZ4X5Da71
jVTDllA1PWLpbkztlNcAW5UidNQg6zSP1uzAMQQLmYHiphTSUqAoI4SLdIkEXlvg4njBeMsW
yyg1OXstkEXQ7aAAeny/Sg4bAMOG6VwrMRF7DPOCJEOMHDiLamgAmu7cT3ir0sYTm3at7t4m
6O8Br3QPwQmi9mvOvdPNFDBP9eXjpMhim4IaAycwDQJlYE3t0QkjKpY1WCfTdsZxtpAdxO3/
NYZ9bzOz2w/FEcKKg6GUXUFr2NIQ9Uz9ylGs2b3vkoO72uuLFlZWQ8/h1RM9ph8nMM1JVNvJ
EzSacXXFbOqnC5j5IZ0nrz6jOTlIaoytyZn7wxLyvQIDAQABo4HZMIHWMHAGA1UdHwRpMGcw
ZaBjoGGGX2h0dHA6Ly9wa2kudGVsZXNlYy5kZS9jZ2ktYmluL3NlcnZpY2UvYWZfRG93bmxv
YWRBUkwuY3JsPy1jcmxfZm9ybWF0PVhfNTA5Ji1pc3N1ZXI9RFRfUk9PVF9DQV8yMB0GA1Ud
DgQWBBRJt8bP6D0ff+pEexMp9/EKcD7eZDAfBgNVHSMEGDAWgBQxw3kbuvVT1xfgiXotF2wK
syudMzAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIBAjANBgkqhkiG9w0BAQUF
AAOCAQEAO+Fad8BIF9ypGOyBr1qJ8L0okqbKWRgScOwo8ueuf5Ys5/JdGTH2Eyt0vb2Asrn3
Z8k5onk74RER7mt4kTN+O18mJ3VTZY4zY+7Pc8OwkiNJIVB1I6EfGOKUhT0/M+l3II2iveah
hSlA9j9zMlgNCWum2oVswD+7jWZkViROrg0/MjUBW+mMgtlyWU+xhoXxdIVW5cP4XPON7kez
UwVw5+VNimmDKOETCYaeXsjqWB4MH/mk1FoEaP0oPosCtli19qEsN1cAZ6sjaI1jpe+Za1z9
S1b2q0CHNNQRkmzsh8UKCwczcrRvDB1ULNhRx8y/MNNDcvEyv4zOSWOoAPfyHDCCBMQwggOs
oAMCAQICBAnydQAwDQYJKoZIhvcNAQEFBQAwWjELMAkGA1UEBhMCREUxEzARBgNVBAoTCkRG
Ti1WZXJlaW4xEDAOBgNVBAsTB0RGTi1QS0kxJDAiBgNVBAMTG0RGTi1WZXJlaW4gUENBIEds
b2JhbCAtIEcwMTAeFw0wNzAyMTQxMTUwMDlaFw0xOTAyMTMwMDAwMDBaMFgxCzAJBgNVBAYT
AkRFMR8wHQYDVQQKExZERk4tQ0VSVCBTZXJ2aWNlcyBHbWJIMSgwJgYDVQQDEx9ERk4tQ0VS
VCBTZXJ2aWNlcyBHbWJIIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAs23qT6oJ//ewoNUeg6f9etrMfrMBEwMsMzWVTV8017SwKYWtkJeK7uWi/FndvDIx5FME
qngZclOOUMHMKFpwq+PJa0ZCV8Nv3CtPQR+YxHp5awxN8It3UfWLTegcE/V94ghAy2cOa4TX
pUK1V+zaSW3+j34vu0hJBAgqt0wYvrmHUpJ9chtihEQoa2heAUg1FFzWH7os71Nk18lbT0c4
eUT7Dbhudu5t8Nu+zhTEWx1xtdprFElbGopNZW9Mf1g0QnEIcGFBWhTzPeeoQNnAiLBsHmS2
pr93M2tS5QH64ur3/eK0NElxepSKd1jiOHwJWKEllHMNgYYVX5Kui5WETQIDAQABo4IBkjCC
AY4wDwYDVR0TAQH/BAUwAwEB/zALBgNVHQ8EBAMCAQYwHQYDVR0OBBYEFMaLz/pE/DpqS2ir
6Oe/OCPlugqWMB8GA1UdIwQYMBaAFEm3xs/oPR9/6kR7Eyn38QpwPt5kMIGIBgNVHR8EgYAw
fjA9oDugOYY3aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY3Js
L2NhY3JsLmNybDA9oDugOYY3aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1j
YS9wdWIvY3JsL2NhY3JsLmNybDCBogYIKwYBBQUHAQEEgZUwgZIwRwYIKwYBBQUHMAKGO2h0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtY2EvcHViL2NhY2VydC9jYWNlcnQu
Y3J0MEcGCCsGAQUFBzAChjtodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNh
L3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDANBgkqhkiG9w0BAQUFAAOCAQEAL0UFMjTjezFpen3Q
dhIaWLHyWD1uwLjb4lfu1wfEFXE0IRjyzvhQVu0tUAue7vG8RFRl+jtZfYSShtd+QyEg2fSk
4BrrCy3CDGNDh7IlFl1/xsGwAfUuoFfmId4nYigyLyVOMs32ekTMoXTrm7PBHrGPuGcaoMer
Spk8vzgEAa0fLAcN+5LHKdk9296UM8mxL4jRccxoeiEcip/98GPjGI8NdVBQrT9PLU4AKxNn
30RPnFryEs9fIjL/X8SUk4aXj4Hjna50dQcEyiRsMZNkAHX7E1ur9EiAdNRR+Ska1usvbpD1
KPpLmvhBNJnsfE3c5ENOyd4i5cSJbkTtzHAh/TCCBa0wggSVoAMCAQICBxVP4g4uweQwDQYJ
KoZIhvcNAQEFBQAwWDELMAkGA1UEBhMCREUxHzAdBgNVBAoTFkRGTi1DRVJUIFNlcnZpY2Vz
IEdtYkgxKDAmBgNVBAMTH0RGTi1DRVJUIFNlcnZpY2VzIEdtYkggQ0EgLSBHMDIwHhcNMTMw
MzAxMDgxOTExWhcNMTYwMjI5MDgxOTExWjCBoDELMAkGA1UEBhMCREUxEDAOBgNVBAgTB0hh
bWJ1cmcxEDAOBgNVBAcTB0hhbWJ1cmcxHzAdBgNVBAoTFkRGTi1DRVJUIFNlcnZpY2VzIEdt
YkgxDDAKBgNVBAsTA1BFVDEaMBgGA1UEAxMRRnJpZWRyaWNoIERlbGdhZG8xIjAgBgkqhkiG
9w0BCQEWE2RlbGdhZG9AZGZuLWNlcnQuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQCmptagMtjKQulYZd2OEJ0NqWXqFq2TPku59rcfSPgb4yyNSD2SRtlsRwkRrG0xHpyg
fNoyS3diihtlIB6Ns2ceOoBL/siqmVB6rR/9D1OzVvgMM4wU+0XW/GoieoGGJeyqE0beoo+Y
TpQocm084b4aGecwE2NPep+yzSoL2835riOFTQaDsYhJCWRtvOQFhA5vNXx7af5brMHn1oFI
j8knGzQIBrS0Zlsch7IdapL+a24IDxVjFi+uASchdGwZSAhX8gYbefYcUjTdrNc521E704Hv
hF3zFS+Eh5diVegVz3VaR14cowBTWmrlAMB0YPY2ziO2Iuz+bmBHM2LymPhrAgMBAAGjggIx
MIICLTAvBgNVHSAEKDAmMBEGDysGAQQBga0hgiwBAQQDADARBg8rBgEEAYGtIYIsAgEEAwAw
CQYDVR0TBAIwADALBgNVHQ8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwME
MB0GA1UdDgQWBBSUQ0NnLqPMHCekQVO/0BdJ9Sv2mzAfBgNVHSMEGDAWgBTGi8/6RPw6akto
q+jnvzgj5boKljAeBgNVHREEFzAVgRNkZWxnYWRvQGRmbi1jZXJ0LmRlMIGjBgNVHR8EgZsw
gZgwSqBIoEaGRGh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNlcnQtc2VydmljZXMtZ21i
aC1jYS9wdWIvY3JsL2dfY2FjcmwuY3JsMEqgSKBGhkRodHRwOi8vY2RwMi5wY2EuZGZuLmRl
L2Rmbi1jZXJ0LXNlcnZpY2VzLWdtYmgtY2EvcHViL2NybC9nX2NhY3JsLmNybDCBvAYIKwYB
BQUHAQEEga8wgawwVAYIKwYBBQUHMAKGSGh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNl
cnQtc2VydmljZXMtZ21iaC1jYS9wdWIvY2FjZXJ0L2dfY2FjZXJ0LmNydDBUBggrBgEFBQcw
AoZIaHR0cDovL2NkcDIucGNhLmRmbi5kZS9kZm4tY2VydC1zZXJ2aWNlcy1nbWJoLWNhL3B1
Yi9jYWNlcnQvZ19jYWNlcnQuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQBFatgOee9YqBk8WJYz
V3TiggOfV/u9YQkt/qZMIRqYmJwX8ef+Aa41uIPLZKaPkxim36Hgsl4rNdWFAMQ5ZBTp/01t
HXJ29daAfvZDEXpNQ3FWB3m8Q4DeQk1tOI24MoQNsDFoO4Bvq6/h+mPINl1AI0gr84XaeCCf
CYRZavni+LyZEuai41WF86IzEUYGqWexnolF72EWoGuRR1hJ3JWixCyTn1QtmDOlyVTrE5YQ
lX2dgupVXsZvcl7p1DuRjJr7q8uXfN20bG4sL1Ce/RxMPaUh94cadEb6QNAImnTj5cq+z5uk
WxKd6fn9oz0DdTpIbeS8OD5up+f6aBaVfO0KMYICFDCCAhACAQEwYzBYMQswCQYDVQQGEwJE
RTEfMB0GA1UEChMWREZOLUNFUlQgU2VydmljZXMgR21iSDEoMCYGA1UEAxMfREZOLUNFUlQg
U2VydmljZXMgR21iSCBDQSAtIEcwMgIHFU/iDi7B5DAJBgUrDgMCGgUAoIGHMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTEzMDcxMDEwNTExMlowIwYJKoZI
hvcNAQkEMRYEFEBcooKhDeHLCGSWphIgGi7w2H3wMCgGCSqGSIb3DQEJDzEbMBkwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBAQUABIIBAHfqSyTjXMXTWMleYP50JyqJ
tlQPgoYoReyHLgaxIH0sIjEPI7BXVSiA9Ox+S2ogQE48ErH3lzk59tUidd6Ma0o3CpLjO2vg
qCJUkjBT6JgqDtCd9V3qFZ8JBPhuHqR9ndper3KHuibS5OJxyGmZR4jCHxmKg6463ybiLosZ
bQdsnBBVRT6d0aJ+qmIcHy6O+Fn+jlPgTFh30XfA3SaYMOpTvR/00vKgILCV+pN+fsjhByoB
fEKEicWnDWy2YhKwW+1RApbC8RB4cc/py+xysvFO9P5K4/Pwgnfl7foxHM7IqxLIRkycv2W7
MZsKCT+7ghDz7w8DWhsbr83W/YJBB/UAAAAAAAA=

--17pEHd4RhPHOinZp--
