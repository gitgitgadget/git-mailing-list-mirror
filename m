From: David Roundy <roundyd@physics.oregonstate.edu>
Subject: insecurity in verify-tag?
Date: Tue, 24 Nov 2009 11:56:50 -0500
Message-ID: <117f2cc80911240856lbbb923buc7d0407bc2cba6a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00c09f99e29b1418a3047920d474
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 17:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCyhj-0000jw-AC
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 17:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933614AbZKXQ4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 11:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933457AbZKXQ4s
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 11:56:48 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:7508 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933544AbZKXQ4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 11:56:45 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1459260qwe.37
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 08:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=52Q4y+hlm791OIysH7JP1zMZ2P2nkfhctqoC+40kfxk=;
        b=mA57FcKaG9J26ZI0Hrk1tL6tvRbUmaWBWs5d0YAcG3Lj+2D/eYHvzd5y0ZPQHYx8hV
         hVN10QQ5XmCoCnrmN0GkAvwDJtLSrcTGWAVm5f2HISabCZFnxM0Mf9ym/Bhcy/ylAOvw
         iyHA1/muzMi9j+iLAEbjRAi2z9o0EWEzLgrqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=GxDnkeW3kFfA+dYbojJ82syLIvuki0QGuwKDZBLYP8IybHuC2AWgxk6cC8RXaTXDjQ
         6kTh1u1bQKb9KZAZyEKnrxO706XduG5KhGUfInBjBmjrwGhPtA1qkdJ9rI63j8bXB43w
         JILt8bVGptC/Wk5YOVNURwWhHh4Xq1YD6CdIc=
Received: by 10.224.27.152 with SMTP id i24mr3282570qac.269.1259081810843; 
	Tue, 24 Nov 2009 08:56:50 -0800 (PST)
X-Google-Sender-Auth: 24b44b39c69e9d1f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133580>

--00c09f99e29b1418a3047920d474
Content-Type: text/plain; charset=UTF-8

I've just been looking at the code and I see what looks like a (minor)
security hole in the verify-tag feature.  In particular, the tag
verification code doesn't check that the tag is signed by the same
user that created the tag.  To be fair, gpg does output the identity
of the key that created the signature as well as the key used to
create the signature, so an astute user could detect that some
shenanigans is going on.

An attack would simply require getting one's own public key into the
keyring of a user.  This probably wouldn't be very easy at the moment,
but if people were to actually use encrypted email (and if they set
their mail agents to download public keys), it might require no more
then sending a signed email to a mailing list.

Of course, you'd also somehow have to trick them into pulling (or
cloning) your corrupt tag, which probably requires compromising a
server (or mirror) somewhere.  But of course, the whole point of
signing tags is to eliminate precisely this danger.

What should be done about this? First, there ought to be a feature to
limit git verify-tag to use a specific keyring.  Maybe there is an
environment variable, and it's just not documented in the man page?

It would also seem like a good idea to at a minimum check that the
name/email associated with the signature is the same as that of the
tagger.  This doesn't gain you *too* much, since an attacker can
always create his own key with any name and email he likes, but at
least it means that users could feel safe adding keys to their public
keyring, as long as those keys have reasonable names/emails associated
with them, and as long as they run git show on a tag before trusting
that that tag came from a particular person.  i.e. it seems reasonable
for me to expect that if I run:

$ git show v1.0
tag v1.0
Tagger: Linus Torvalds ...
...
[user carefully reads the Tagger line...]
$ git verify-tag v1.0 && make

That I won't be running make on a repository that wasn't signed by a
key that at least *claims* to belong to Linus Torvalds.

Thoughts?
-- 
David Roundy

--00c09f99e29b1418a3047920d474
Content-Type: text/plain; charset=US-ASCII; name="tagtest.txt"
Content-Disposition: attachment; filename="tagtest.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2ewlblk1

Cm1rZGlyIHRlbXAKY2QgdGVtcApnaXQgaW5pdApJbml0aWFsaXplZCBlbXB0eSBHaXQgcmVwb3Np
dG9yeSBpbiAvdG1wL3RlbXAvLmdpdC8KZGF0ZSA+IGZvbwpnaXQgYWRkIGZvbwpleHBvcnQgR0lU
X0FVVEhPUl9OQU1FPSJTb21lb25lIGVsc2UiCmV4cG9ydCBHSVRfQVVUSE9SX0VNQUlMPSJub3Rt
ZUBleGFtcGxlLmNvbSIKZXhwb3J0IEdJVF9DT01NSVRURVJfTkFNRT0iTGludXMgVG9ydmFsZHMi
CmV4cG9ydCBHSVRfQ09NTUlUVEVSX0VNQUlMPSJsaW51c0BleGFtcGxlLmNvbSIKZ2l0IGNvbW1p
dCAtbSAnaGVsbG8gd29ybGQnCkNyZWF0ZWQgaW5pdGlhbCBjb21taXQgZGMzYjdlOTogaGVsbG8g
d29ybGQKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGZvbwpnaXQgdGFnIC11IGRyb3VuZHkgLW0gZm9vIHYxLjAKZ3Bn
OiBJbnZhbGlkIHBhc3NwaHJhc2U7IHBsZWFzZSB0cnkgYWdhaW4gLi4uCmdwZzogSW52YWxpZCBw
YXNzcGhyYXNlOyBwbGVhc2UgdHJ5IGFnYWluIC4uLgoKZ2l0IHZlcmlmeS10YWcgdjEuMApncGc6
IFNpZ25hdHVyZSBtYWRlIFR1ZSAyNCBOb3YgMjAwOSAxMTo0MTo0OSBBTSBFU1QgdXNpbmcgRFNB
IGtleSBJRCBEM0Q1QkNFQwpncGc6IEdvb2Qgc2lnbmF0dXJlIGZyb20gIkRhdmlkIFJvdW5keSA8
cm91bmR5ZEBwaHlzaWNzLm9yZWdvbnN0YXRlLmVkdT4iCmdwZzogICAgICAgICAgICAgICAgIGFr
YSAiRGF2aWQgUm91bmR5IDxkcm91bmR5QGRhcmNzLm5ldD4iCmdwZzogICAgICAgICAgICAgICAg
IGFrYSAiRGF2aWQgUm91bmR5IDxkcm91bmR5QGFicmlkZ2VnYW1lLm9yZz4iCmdwZzogICAgICAg
ICAgICAgICAgIGFrYSAiRGF2aWQgUm91bmR5IDxkYXZlcm91bmR5QGdtYWlsLmNvbT4iCgpnaXQg
c2hvdyB2MS4wCnRhZyB2MS4wClRhZ2dlcjogTGludXMgVG9ydmFsZHMgPGxpbnVzQGV4YW1wbGUu
Y29tPgpEYXRlOiAgIFR1ZSBOb3YgMjQgMTE6NDE6NDkgMjAwOSAtMDUwMAoKZm9vCi0tLS0tQkVH
SU4gUEdQIFNJR05BVFVSRS0tLS0tClZlcnNpb246IEdudVBHIHYxLjQuOSAoR05VL0xpbnV4KQoK
aUVZRUFCRUNBQVlGQWtzTURNMEFDZ2tRUTZ1Wkk5UFZ2T3lYRlFDZ29jNFVZZk5GWXpWSDRIZHVM
ZGg5VlVjLwpOU2tBbjA1eXIvQVJuV0dVQzhJL09tamhaSkVqRzVPYQo9cm80OAotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KY29tbWl0IGRjM2I3ZTlmOGY1YzQ5YmRmZTg4MTZhYmRiNGJiMzky
YzMwZTNlZjUKQXV0aG9yOiBTb21lb25lIGVsc2UgPG5vdG1lQGV4YW1wbGUuY29tPgpEYXRlOiAg
IFR1ZSBOb3YgMjQgMTE6NDE6NDkgMjAwOSAtMDUwMAoKICAgIGhlbGxvIHdvcmxkCgpkaWZmIC0t
Z2l0IGEvZm9vIGIvZm9vCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmMxODU3
ZmEKLS0tIC9kZXYvbnVsbAorKysgYi9mb28KQEAgLTAsMCArMSBAQAorVHVlIE5vdiAyNCAxMTo0
MTo0OSBFU1QgMjAwOQo=
--00c09f99e29b1418a3047920d474--
