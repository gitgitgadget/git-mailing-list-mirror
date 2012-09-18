From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive --format zip utf-8 issues
Date: Tue, 18 Sep 2012 21:40:57 +0200
Message-ID: <5058CE49.3070108@lsrfire.ath.cx>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx> <5026D081.2040906@tu-clausthal.de> <20120830222603.GA20289@sigill.intra.peff.net> <5046634A.4020608@lsrfire.ath.cx> <7vehmh8prt.fsf@alter.siamese.dyndns.org> <5047A9C0.9020200@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070103050002030606040608"
Cc: Jeff King <peff@peff.net>,
	Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:41:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3fp-0004YS-Ne
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab2IRTlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:41:25 -0400
Received: from india601.server4you.de ([85.25.151.105]:42872 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176Ab2IRTlX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:41:23 -0400
Received: from [192.168.2.105] (p579BE98C.dip.t-dialin.net [87.155.233.140])
	by india601.server4you.de (Postfix) with ESMTPSA id A2FC7B1;
	Tue, 18 Sep 2012 21:41:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <5047A9C0.9020200@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205855>

This is a multi-part message in MIME format.
--------------070103050002030606040608
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello again,

so two weeks have passed, and I've moved at a glacial pace towards a 
method how to measure compatibility of our generated ZIP files.  Sorry, 
I just keep getting distracted.

Anyway, the idea is to have a bunch of files with names using different 
scripts, zip them with several packers (including git archive), unzip 
them and compare the result with the original files.

As test corpus I used files named like the pangrams on this UTF-8 
sampler page, the exact commands are attached:

    http://www.columbia.edu/~fdc/utf8/index.html#quickbrownfox

The numbers below are how many lines the output of diff -ru contains for 
this pair of packer and unpacker.  There are 37 files, so the worst 
result is 74 lines of difference ("Only in [...]" for both sides), while 
0 indicates a perfect score.

Hmm, come to think of it, an empty directory would show up as 37, so 
this metric is not ideal.  A better one would be to simply give one 
point for each correctly unpacked file.

                                          Windows    Info-ZIP unzip
                             7-Zip PeaZip builtin Linux msysgit Windows
7-Zip 9.20                      0      0      46    26      43      43
PeaZip 4.7.1 win64              0      0      46    26      42      42
Info-ZIP zip 3.0 Linux          0      0      72     0      43      43
Info-ZIP zip 3.0 Windows       45     45     n/a     0      43      43
git-master                     72     72      72    60      72      72
git-master-patch1               0      0      72    60      72      72
git-master-patch2               0      0      72     0      72      72
git-v1.7.11.msysgit.1          72     72      72    60      72      72
git-v1.7.11.msysgit.1-patch1    0      0      72    60      72      72
git-v1.7.11.msysgit.1-patch2    0      0      72     0      72      72

Info-ZIP's programs don't work too well on Windows.  The built-in 
unzipper of Windows 7 even refuses to open the file created by the 
Windows version of zip.  Speaking of which, this is the worst of the 
unpackers.

With the two patches applied, we can say "use 7-Zip or PeaZip on Windows 
and unzip on Linux" and filenames with all tested characters will be 
preserved.  I was surprised to see this working fine with msysgit like 
that, even though no reencoding is introduced by the patches.

I wonder what 7-Zip and PeaZip do that gives them a slightly nicer score 
with the Windows-internal unzipper.  Umlauts, Nordic characters and 
accents are preserved by that combination.  It seems that unzip on Linux 
fails to unpack exactly these names, so perhaps they employ a dirty 
trick like using the local encoding in the ZIP file, which makes it 
unportable.

I'll reply with the two patches, which contain basically the same code 
as the previous patch, only split up.  The second one declares that 
filenames with UTF-8 encoding came from Unix (instead of FAT), which 
makes unzip happy.  This, however, implies that we contain Unix 
permissions for these entries, which is a bit ugly.

René

--------------070103050002030606040608
Content-Type: text/plain; charset=windows-1252;
 name="pangrams.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pangrams.sh"

IyEvYmluL3NoDQooDQoJbWtkaXIgcGFuZ3JhbXMNCgljZCBwYW5ncmFtcw0KDQoJZWNobyBF
bmdsaXNoID4iVGhlIHF1aWNrIGJyb3duIGZveCBqdW1wcyBvdmVyIHRoZSBsYXp5IGRvZyIN
CgllY2hvIElyaXNoIDEgPiJBbiDhuINmdWlsIGRvIMSLcm/DrSBhZyBidWFsYeG4iyDDsyDh
uJ9haXTDrW9zIGFuIMShcsOhIGEg4bmBZWFsbCINCgllY2hvIElyaXNoIDIgPiJsZW5hIOG5
l8OzZyDDqWFkYSDDsyDhuaFsw60gZG8gbGVhc2Eg4bmrw7oiDQoJZWNobyBJcmlzaCAzID4i
RCfhuJ91YXNjYWlsIMONb3NhIMOacuG5gWFjIG5hIGjDk2nEoWUgQmVhbm5haeG5q2UgcMOz
ciINCgllY2hvIElyaXNoIDQgPiLDiWF2YSBhZ3VzIMOB4biLYWnhuYEiDQoJZWNobyBEdXRj
aCA+IlBhJ3Mgd8SzemUgbHlueCBiZXphZyB2cm9vbSBoZXQgZmlrc2UgYXF1YWR1Y3QiDQoJ
ZWNobyBHZXJtYW4gMSA+IkZhbHNjaGVzIMOcYmVuIHZvbiBYeWxvcGhvbm11c2lrIHF1w6Rs
dCINCgllY2hvIEdlcm1hbiAyID4iamVkZW4gZ3LDtsOfZXJlbiBad2VyZyINCgllY2hvIE5v
cndlZ2lhbiA+IkJsw6Viw6Zyc3lsdGV0w7h5Ig0KCWVjaG8gRGFuaXNoID4iSMO4aiBibHkg
Z29tIHZhbmR0IGZyw6ZrIHNleHF1aXogcMOlIHdjIg0KCWVjaG8gU3dlZGlzaCA+IkZseWdh
bmRlIGLDpGNrYXNpbmVyIHPDtmthIHN0cmF4IGh3aWxhIHDDpSBtanVrYSB0dXZvciINCgll
Y2hvIEljZWxhbmRpYyA+IlPDpnbDtnIgZ3LDqXQgw6HDsGFuIMO+dsOtIMO6bHBhbiB2YXIg
w7Nuw710Ig0KCWVjaG8gRmlubmlzaCA+IlTDtnJreWxlbXBpasOkdm9uZ2FoZHVzIg0KCWVj
aG8gUG9saXNoID4iUGNobsSFxIcgdyB0xJkgxYLDs2TFuiBqZcW8YSBsdWIgb3NpZW0gc2ty
ennFhCBmaWciDQoJZWNobyBDemVjaCA+IlDFmcOtbGnFoSDFvmx1xaVvdcSNa8O9IGvFr8WI
IMO6cMSbbCDEj8OhYmVsc2vDqSBrw7NkeSINCgllY2hvIFNsb3ZhayAxID4iU3RhcsO9IGvD
tMWIIG5hIGjFlWJlIGtuw61oIMW+dWplIHTDrcWha28gcG92w6RkbnV0w6kgcnXFvmUiDQoJ
ZWNobyBTbG92YWsgMiA+Im5hIHN0xLpwZSBzYSDEj2F0ZcS+IHXEjcOtIGt2w6FrYcWlIG5v
dsO6IMOzZHUgbyDFvml2b3RlIg0KCWVjaG8gbW9ub3RvbmljIEdyZWVrID4izr7Otc+DzrrO
tc+AzqzOts+JIM+EzrfOvSDPiM+Fz4fOv8+GzrjPjM+BzrEgzrLOtM61zrvPhc6zzrzOr86x
Ig0KCWVjaG8gcG9seXRvbmljIEdyZWVrID4izr7Otc+DzrrOtc+AzqzOts+JIM+E4b20zr0g
z4jPhc+Hzr/Phs64z4zPgc6xIM6yzrTOtc67z4XOs868zq/OsSINCgllY2hvIFJ1c3NpYW4g
PiLQodGK0LXRiNGMINC20LUg0LXRidGRINGN0YLQuNGFINC80Y/Qs9C60LjRhSDRhNGA0LDQ
vdGG0YPQt9GB0LrQuNGFINCx0YPQu9C+0Log0LTQsCDQstGL0L/QtdC5INGH0LDRjiINCgll
Y2hvIEJ1bGdhcmlhbiAxID4i0JbRitC70YLQsNGC0LAg0LTRjtC70Y8g0LHQtdGI0LUg0YnQ
sNGB0YLQu9C40LLQsCINCgllY2hvIEJ1bGdhcmlhbiAyID4i0YfQtSDQv9GD0YXRitGCLCDQ
utC+0LnRgtC+INGG0YrRhNC90LAsINC30LDQvNGA0YrQt9C90LAg0LrQsNGC0L4g0LPRjNC+
0L0iDQoJZWNobyBOb3J0aGVybiBTYW1pID4iVnVvbCBSdW/Fp2EgZ2XEkWdnaWlkIGxlYXQg
bcOhxYtnYSBsdW9zYSBqYSDEjXVvdsW+xb5hIg0KCWVjaG8gSHVuZ2FyaWFuID4iw4FydsOt
enTFsXLFkSB0w7xrw7ZyZsO6csOzZ8OpcCINCgllY2hvIFNwYW5pc2ggMSA+IkVsIHBpbmfD
vGlubyBXZW5jZXNsYW8gaGl6byBraWzDs21ldHJvcyBiYWpvIGV4aGF1c3RpdmEiDQoJZWNo
byBTcGFuaXNoIDIgPiJsbHV2aWEgeSBmcsOtbyBhw7FvcmFiYSBhIHN1IHF1ZXJpZG8gY2Fj
aG9ycm8iDQoJZWNobyBQb3J0dWd1ZXNlIDEgPiJPIHByw7N4aW1vIHbDtG8gw6Agbm9pdGUg
c29icmUgbyBBdGzDom50aWNvIg0KCWVjaG8gUG9ydHVndWVzZSAyID4icMO1ZSBmcmVxw7xl
bnRlbWVudGUgbyDDum5pY28gbcOpZGljbyINCgllY2hvIEZyZW5jaCAxID4iTGVzIG5hw69m
cyDDpmdpdGhhbGVzIGjDonRpZnMgcG9uZGFudCDDoCBOb8OrbCBvw7kgaWwgZ8OobGUiDQoJ
ZWNobyBGcmVuY2ggMiA+InNvbnQgc8O7cnMgZCfDqnRyZSBkw6nDp3VzIGVuIHZveWFudCBs
ZXVycyBkcsO0bGVzIg0KCWVjaG8gRnJlbmNoIDMgPiJkJ8WTdWZzIGFiw65tw6lzIg0KCWVj
aG8gRXNwZXJhbnRvID4iRcSlb8WdYW7EnW8gxIlpdcS1YcWtZGUiDQoJZWNobyBIZWJyZXcg
PiLXlteUINeb15nXoyDXodeq150g15zXqdee15XXoiDXkNeZ15og16rXoNem15cg16fXqNek
15Mg16LXpSDXmNeV15Eg15HXktefIg0KCWVjaG8gSGlyYWdhbmEgMSA+IuOBhOOCjeOBr+OB
q+OBu+OBuOOBqeOAgOOBoeOCiuOBrOOCi+OCkiINCgllY2hvIEhpcmFnYW5hIDIgPiLjgo/j
gYzjgojjgZ/jgozjgZ7jgIDjgaTjga3jgarjgonjgoAiDQoJZWNobyBIaXJhZ2FuYSAzID4i
44GG44KQ44Gu44GK44GP44KE44G+44CA44GR44G144GT44GI44GmIg0KCWVjaG8gSGlyYWdh
bmEgNCA+IuOBguOBleOBjeOChuOCgeOBv+OBmOOAgOOCkeOBsuOCguOBm+OBmiINCikNCg==
--------------070103050002030606040608--
