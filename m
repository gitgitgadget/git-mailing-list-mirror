From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git hang with corrupted .pack
Date: Tue, 20 Oct 2009 17:14:26 +0200
Message-ID: <81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com>
References: <20091014042249.GA5250@hexapodia.org>
	 <20091014142351.GI9261@spearce.org>
	 <alpine.LFD.2.00.0910141208170.20122@xanadu.home>
	 <20091014161259.GK9261@spearce.org>
	 <alpine.LFD.2.00.0910141234540.20122@xanadu.home>
	 <20091014180302.GL9261@spearce.org>
	 <alpine.LFD.2.00.0910141435040.20122@xanadu.home>
	 <7vbpk985t1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175d67ec70b91c04765f514e
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 17:14:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0GPz-0005aI-3o
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 17:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbZJTPOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 11:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbZJTPOY
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 11:14:24 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:34865 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZJTPOX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 11:14:23 -0400
Received: by fxm18 with SMTP id 18so6539398fxm.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=gBOAencw/IFxNhmp3qrqyZrYmKPH73Dffmu0ydRFAis=;
        b=LYcKV8NJxG38fAoSiUZWXhgM654T3l5rbPXYAjrGGEZlrlzBx153rZNxUS16OmYeuj
         mTIyjRBvwgChMLWa1xsmSrk0tf8f/10bJKO5hwNbUM8diXBISDojTCvmBpV/dbDNiuLs
         WOKG/5k3iPbGWe6vImvFPgoFo6ed3Apl0zSXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xtEfgAdFfHah/F2UhJM/SkyaxlrIMPsEPwhrX8luBzHObYJcxktfRE5Dc1VDZxhfH6
         6z0Kg85ggYyp77O1xFzWP3W3EkSKQ2QQTEC4yuG+iryLnuoKOmvmbxSnqJ6cFsGNajY1
         UZ8XQmzRODQD2y9sw9DpDxs69yUR0ssLRuoMc=
Received: by 10.204.151.209 with SMTP id d17mr6499549bkw.120.1256051667154; 
	Tue, 20 Oct 2009 08:14:27 -0700 (PDT)
In-Reply-To: <7vbpk985t1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130801>

--0015175d67ec70b91c04765f514e
Content-Type: text/plain; charset=UTF-8

On Thu, Oct 15, 2009 at 09:39, Junio C Hamano <gitster@pobox.com> wrote:
> Nicolas Pitre <nico@fluxnic.net> writes:
>
>> I confirm this test without the fix reproduces the infinite loop (and
>> does stall the test suite).
>
> Thanks, both of you.

I seem to have problems with this change (on Cygwin). Sometimes
accessing an object in a pack fails in unpack_compressed_entry.
When it happens, both avail_in and avail_out of the stream are 0,
and the reported status is Z_BUF_ERROR.
Output with the second attached patch:

error: *** inflate error: 0x862380 size=1256, avail_in=0 (was 697),
avail_out=0 (was 1256)
error: *** unpack_compressed_entry failed
error: failed to read object 3296766eb5531ef051ae392114de5d75556f5613
at offset 2620741 from
.git/objects/pack/pack-996206790aaefbf4d34c86b3ff546bb924546b7c.pack
fatal: object 3296766eb5531ef051ae392114de5d75556f5613 is corrupted

I cannot reproduce the problem on a normal system (a 64bit, reasonably modern
Linux in my case). An attempt to use an upgraded zlib on this cygwin system was
not successful, there was an updated library, but a clean recompile didn't
change anything.

I worked the case around by allocating a bit more than uncompressed data need.
In case someone else also sees the problem, below is how. The size of the
overallocation is arbitrary.

diff --git a/sha1_file.c b/sha1_file.c
index 4cc8939..66c2519 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1585,11 +1585,11 @@ static void *unpack_compressed_entry(struct
packed_git *p,
 	z_stream stream;
 	unsigned char *buffer, *in;

-	buffer = xmalloc(size + 1);
-	buffer[size] = 0;
+	buffer = xmalloc(size + 8);
+	memset(buffer + size, 0, 8);
 	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
-	stream.avail_out = size;
+	stream.avail_out = size + 8;

 	git_inflate_init(&stream);
 	do {
-- 
1.6.5.59.g000dd

The problematic repo is a little big to post (it's my cygwin-git repo),
I'll have to find hosting for it first.

--0015175d67ec70b91c04765f514e
Content-Type: application/octet-stream; 
	name="0001-Workaround-inflate-sometimes-failing-to-unpack-data.diff"
Content-Disposition: attachment; 
	filename="0001-Workaround-inflate-sometimes-failing-to-unpack-data.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g10s9t9e0

RnJvbSA2NDNmZGY1MGU0MzQzYzNjZTNhNGI5OTE4M2RiYThkMzVhMTBjODc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDIwIE9jdCAyMDA5IDE2OjQyOjI2ICswMjAwClN1YmplY3Q6IFtQQVRDSCAxLzJdIFdv
cmthcm91bmQgaW5mbGF0ZSBzb21ldGltZXMgZmFpbHMgdG8gdW5wYWNrIGRhdGEKCldoZW4gaXQg
aGFwcGVucywgemxpYiBzdHJlYW0ncyBhdmFpbF9pbiBhbmQgYXZhaWxfb3V0IGFyZSAwLCB0aGUg
cmV0dXJuZWQKc3RhdHVzIGlzIFpfQlVGX0VSUk9SLiBUaGUgdmFsdWVzIHdlcmVuJ3QgMCBiZWZv
cmUgY2FsbGluZyBpbmZsYXRlLgoKZXJyb3I6ICoqKiBpbmZsYXRlIGVycm9yOiAweDg2MjM4MCBz
aXplPTEyNTYsIGF2YWlsX2luPTAgKHdhcyA2OTcpLCBhdmFpbF9vdXQ9MCAod2FzIDEyNTYpCmVy
cm9yOiAqKiogdW5wYWNrX2NvbXByZXNzZWRfZW50cnkgZmFpbGVkCmVycm9yOiBmYWlsZWQgdG8g
cmVhZCBvYmplY3QgMzI5Njc2NmViNTUzMWVmMDUxYWUzOTIxMTRkZTVkNzU1NTZmNTYxMyBhdCBv
ZmZzZXQgMjYyMDc0MSBmcm9tIC5naXQvb2JqZWN0cy9wYWNrL3BhY2stOTk2MjA2NzkwYWFlZmJm
NGQzNGM4NmIzZmY1NDZiYjkyNDU0NmI3Yy5wYWNrCmZhdGFsOiBvYmplY3QgMzI5Njc2NmViNTUz
MWVmMDUxYWUzOTIxMTRkZTVkNzU1NTZmNTYxMyBpcyBjb3JydXB0ZWQKLS0tCiBzaGExX2ZpbGUu
YyB8ICAgIDYgKysrLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zaGExX2ZpbGUuYyBiL3NoYTFfZmlsZS5jCmluZGV4IDRj
Yzg5MzkuLjY2YzI1MTkgMTAwNjQ0Ci0tLSBhL3NoYTFfZmlsZS5jCisrKyBiL3NoYTFfZmlsZS5j
CkBAIC0xNTg1LDExICsxNTg1LDExIEBAIHN0YXRpYyB2b2lkICp1bnBhY2tfY29tcHJlc3NlZF9l
bnRyeShzdHJ1Y3QgcGFja2VkX2dpdCAqcCwKIAl6X3N0cmVhbSBzdHJlYW07CiAJdW5zaWduZWQg
Y2hhciAqYnVmZmVyLCAqaW47CiAKLQlidWZmZXIgPSB4bWFsbG9jKHNpemUgKyAxKTsKLQlidWZm
ZXJbc2l6ZV0gPSAwOworCWJ1ZmZlciA9IHhtYWxsb2Moc2l6ZSArIDgpOworCW1lbXNldChidWZm
ZXIgKyBzaXplLCAwLCA4KTsKIAltZW1zZXQoJnN0cmVhbSwgMCwgc2l6ZW9mKHN0cmVhbSkpOwog
CXN0cmVhbS5uZXh0X291dCA9IGJ1ZmZlcjsKLQlzdHJlYW0uYXZhaWxfb3V0ID0gc2l6ZTsKKwlz
dHJlYW0uYXZhaWxfb3V0ID0gc2l6ZSArIDg7CiAKIAlnaXRfaW5mbGF0ZV9pbml0KCZzdHJlYW0p
OwogCWRvIHsKLS0gCjEuNi41LjU5LmcwMDBkZAoK
--0015175d67ec70b91c04765f514e
Content-Type: application/octet-stream; 
	name="0002-Debugging-strange-failure-in-zlibs-inflate.diff"
Content-Disposition: attachment; 
	filename="0002-Debugging-strange-failure-in-zlibs-inflate.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g10sa4ob1

RnJvbSBmYzViNDdkOTUzZjE3MWQ3NTkxMzQ5YWNhZDlhMjNkM2VjNjgzY2U5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDIwIE9jdCAyMDA5IDE1OjUzOjMzICswMjAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIERl
YnVnZ2luZyBzdHJhbmdlIGZhaWx1cmUgaW4gemxpYnMgaW5mbGF0ZQoKLS0tCiBzaGExX2ZpbGUu
YyB8ICAgMTggKysrKysrKysrKysrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2hhMV9maWxlLmMgYi9zaGExX2Zp
bGUuYwppbmRleCA2NmMyNTE5Li4xYmYyNDBlIDEwMDY0NAotLS0gYS9zaGExX2ZpbGUuYworKysg
Yi9zaGExX2ZpbGUuYwpAQCAtMTU5NCwxMCArMTU5NCwyNCBAQCBzdGF0aWMgdm9pZCAqdW5wYWNr
X2NvbXByZXNzZWRfZW50cnkoc3RydWN0IHBhY2tlZF9naXQgKnAsCiAJZ2l0X2luZmxhdGVfaW5p
dCgmc3RyZWFtKTsKIAlkbyB7CiAJCWluID0gdXNlX3BhY2socCwgd19jdXJzLCBjdXJwb3MsICZz
dHJlYW0uYXZhaWxfaW4pOworCQl1bnNpZ25lZCBwcmV2X2FpbiA9IHN0cmVhbS5hdmFpbF9pbjsK
KwkJdW5zaWduZWQgcHJldl9hb3V0ID0gc3RyZWFtLmF2YWlsX291dDsKKwkJaWYgKCFzdHJlYW0u
YXZhaWxfaW4pCisJCQllcnJvcigiKioqIGF2YWlsX2luPTAsIGluZmxhdGUgd2lsbCBmYWlsISIp
OworCQlpZiAoIXN0cmVhbS5hdmFpbF9vdXQpCisJCQllcnJvcigiKioqIGF2YWlsX291dD0wLCBp
bmZsYXRlIHdpbGwgZmFpbCEiKTsKIAkJc3RyZWFtLm5leHRfaW4gPSBpbjsKIAkJc3QgPSBnaXRf
aW5mbGF0ZSgmc3RyZWFtLCBaX0ZJTklTSCk7CiAJCWlmIChzdCA9PSBaX0JVRl9FUlJPUiAmJiAo
c3RyZWFtLmF2YWlsX2luIHx8ICFzdHJlYW0uYXZhaWxfb3V0KSkKKyAgICAgICAgICAgICAgICB7
CisJCQllcnJvcigiKioqIGluZmxhdGUgZXJyb3I6ICVwIHNpemU9JWx1LCAiCisJCQkgICAgICAi
YXZhaWxfaW49JWQgKHdhcyAldSksICIKKwkJCSAgICAgICJhdmFpbF9vdXQ9JWQgKHdhcyAldSki
LAorCQkJICAgICAgYnVmZmVyLCBzaXplLAorCQkJICAgICAgc3RyZWFtLmF2YWlsX2luLCBwcmV2
X2FpbiwKKwkJCSAgICAgIHN0cmVhbS5hdmFpbF9vdXQsIHByZXZfYW91dCk7CiAJCQlicmVhazsK
KyAgICAgICAgICAgICAgICB9CiAJCWN1cnBvcyArPSBzdHJlYW0ubmV4dF9pbiAtIGluOwogCX0g
d2hpbGUgKHN0ID09IFpfT0sgfHwgc3QgPT0gWl9CVUZfRVJST1IpOwogCWdpdF9pbmZsYXRlX2Vu
ZCgmc3RyZWFtKTsKQEAgLTE2NTQsNiArMTY2OCw4IEBAIHN0YXRpYyB2b2lkICpjYWNoZV9vcl91
bnBhY2tfZW50cnkoc3RydWN0IHBhY2tlZF9naXQgKnAsIG9mZl90IGJhc2Vfb2Zmc2V0LAogCQlk
ZWx0YV9iYXNlX2NhY2hlZCAtPSBlbnQtPnNpemU7CiAJfSBlbHNlIHsKIAkJcmV0ID0geG1lbWR1
cHooZW50LT5kYXRhLCBlbnQtPnNpemUpOworCQlpZiAoIXJldCkKKwkJCWZwcmludGYoc3RkZXJy
LCAiKioqIG5vIG1lbW9yeVxuIik7CiAJfQogCSp0eXBlID0gZW50LT50eXBlOwogCSpiYXNlX3Np
emUgPSBlbnQtPnNpemU7CkBAIC0xODE1LDYgKzE4MzEsOCBAQCB2b2lkICp1bnBhY2tfZW50cnko
c3RydWN0IHBhY2tlZF9naXQgKnAsIG9mZl90IG9ial9vZmZzZXQsCiAJY2FzZSBPQkpfQkxPQjoK
IAljYXNlIE9CSl9UQUc6CiAJCWRhdGEgPSB1bnBhY2tfY29tcHJlc3NlZF9lbnRyeShwLCAmd19j
dXJzLCBjdXJwb3MsICpzaXplcCk7CisJCWlmICghZGF0YSkKKwkJCWVycm9yKCIqKiogdW5wYWNr
X2NvbXByZXNzZWRfZW50cnkgZmFpbGVkIik7CiAJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCWRhdGEg
PSBOVUxMOwotLSAKMS42LjUuNTkuZzAwMGRkCgo=
--0015175d67ec70b91c04765f514e--
