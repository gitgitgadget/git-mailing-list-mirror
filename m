From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sat, 24 Mar 2012 21:49:55 +0100
Message-ID: <4F6E3373.7090500@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F6A33C5.2080909@gmx.net> <20120321201722.GA15021@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030205090006010705050507"
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 21:50:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBXum-0003hn-CE
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 21:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab2CXUti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 16:49:38 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:35667 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751233Ab2CXUth (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 16:49:37 -0400
Received: (qmail invoked by alias); 24 Mar 2012 20:49:35 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.174.228]
  by mail.gmx.net (mp019) with SMTP; 24 Mar 2012 21:49:35 +0100
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX18LU9wACj4LU0jvQTGmv4gKPP1uzP02RodbkPPjKu
	+xOo6GdKutB+oh
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120321201722.GA15021@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193846>

This is a multi-part message in MIME format.
--------------030205090006010705050507
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.2012 21:17, Jeff King wrote:
> On Wed, Mar 21, 2012 at 09:02:13PM +0100, Ivan Todoroski wrote:
> 
>>> Something in me feels slightly uncomfortable with that, just because
>>> simple newline-delimited formats make it easy for people to hack on the
>>> tool and feed input from unexpected sources.
>> I understand what you mean. How about this:
>>
>> If both --stdin and --stateless-rpc are specified to fetch-pack, it
>> will use pkt-line to read the refs from stdin before handing off
>> stdin to get_remote_heads().
>>
>> However, if only --stdin is specified, it will read refs from stdin
>> in a script-friendly newline delimited format, one ref per line. This
>> is okay because when --stateless-rpc is not specified
>> get_remote_heads() reads from an fd different from stdin so there is
>> no issue with residual buffers in this case.
>>
>> This way you preserve scriptability for any other callers who don't
>> use --stateless-rpc.
>>
>> How does this sound?
> 
> I think that sounds quite reasonable, and shouldn't be more than a few
> extra lines to implement.
> 
> -Peff


I wrote the code for this and went to write the test cases, but the test 
suite is not cooperating. :(

I'll send just the code changes for comments while I'm figuring out the 
test suite. I'll include the test cases along with better commit 
messages in the next version of the patches.

So, back to the test suite problem. To get familiar with it I first ran 
the test suite against the vanilla "maint" branch without any of my 
changes, just to see what I should expect on properly running code.

Unfortunately it failed, and to make matters worse it failed exactly on 
the parts dealing with smart HTTP, which is what I need to test in the 
first place. Talk about Murphy's law...

Is it failing for anyone else on the vanilla "maint" branch? I would 
appreciate any help I could get here.

My machine is CentOS 5.8 with latest updates and I have the httpd 
package installed. Here is the command that is failing (you can find the 
full output in the attachment):


$ GIT_TEST_HTTPD=yes ./t5551-http-fetch.sh -i -v
[... skip successful tests ...]
ok 5 - used upload-pack service

expecting success:
         git clone $HTTPD_URL/smart-redir-perm/repo.git --quiet repo-p

error: RPC failed; result=22, HTTP code = 405
fatal: The remote end hung up unexpectedly
not ok - 6 follow redirects (301)
#
#               git clone $HTTPD_URL/smart-redir-perm/repo.git --quiet 
repo-p
#


--------------030205090006010705050507
Content-Type: text/plain;
 name="http-fetch.log"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="http-fetch.log"

SW5pdGlhbGl6ZWQgZW1wdHkgR2l0IHJlcG9zaXRvcnkgaW4gL2hvbWUvaXRvZG9yb3NraS9n
aXQvdC90cmFzaCBkaXJlY3RvcnkudDU1NTEtaHR0cC1mZXRjaC8uZ2l0LwpleHBlY3Rpbmcg
c3VjY2VzczogCgllY2hvIGNvbnRlbnQgPmZpbGUgJiYKCWdpdCBhZGQgZmlsZSAmJgoJZ2l0
IGNvbW1pdCAtbSBvbmUKClttYXN0ZXIgKHJvb3QtY29tbWl0KSBiYTM2NTQwXSBvbmUKIEF1
dGhvcjogQSBVIFRob3IgPGF1dGhvckBleGFtcGxlLmNvbT4KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGZpbGUKb2sgMSAtIHNldHVwIHJl
cG9zaXRvcnkKCmV4cGVjdGluZyBzdWNjZXNzOiAKCW1rZGlyICIkSFRUUERfRE9DVU1FTlRf
Uk9PVF9QQVRIL3JlcG8uZ2l0IiAmJgoJKGNkICIkSFRUUERfRE9DVU1FTlRfUk9PVF9QQVRI
L3JlcG8uZ2l0IiAmJgoJIGdpdCAtLWJhcmUgaW5pdAoJKSAmJgoJZ2l0IHJlbW90ZSBhZGQg
cHVibGljICIkSFRUUERfRE9DVU1FTlRfUk9PVF9QQVRIL3JlcG8uZ2l0IiAmJgoJZ2l0IHB1
c2ggcHVibGljIG1hc3RlcjptYXN0ZXIKCkluaXRpYWxpemVkIGVtcHR5IEdpdCByZXBvc2l0
b3J5IGluIC9ob21lL2l0b2Rvcm9za2kvZ2l0L3QvdHJhc2ggZGlyZWN0b3J5LnQ1NTUxLWh0
dHAtZmV0Y2gvaHR0cGQvd3d3L3JlcG8uZ2l0LwpUbyAvaG9tZS9pdG9kb3Jvc2tpL2dpdC90
L3RyYXNoIGRpcmVjdG9yeS50NTU1MS1odHRwLWZldGNoL2h0dHBkL3d3dy9yZXBvLmdpdAog
KiBbbmV3IGJyYW5jaF0gICAgICBtYXN0ZXIgLT4gbWFzdGVyCm9rIDIgLSBjcmVhdGUgaHR0
cC1hY2Nlc3NpYmxlIGJhcmUgcmVwb3NpdG9yeQoKZXhwZWN0aW5nIHN1Y2Nlc3M6IAoJR0lU
X0NVUkxfVkVSQk9TRT0xIGdpdCBjbG9uZSAtLXF1aWV0ICRIVFRQRF9VUkwvc21hcnQvcmVw
by5naXQgY2xvbmUgMj5lcnIgJiYKCXRlc3RfY21wIGZpbGUgY2xvbmUvZmlsZSAmJgoJdHIg
J1wwMTUnIFEgPGVyciB8CglzZWQgLWUgIgoJCXMvUVwkLy8KCQkvXlsqXSAvZAoJCS9eJC9k
CgkJL148ICQvZAoKCQkvXltePjxdL3sKCQkJcy9eLz4gLwoJCX0KCgkJL14+IFVzZXItQWdl
bnQ6IC9kCgkJL14+IEhvc3Q6IC9kCgkJL14+IFBPU1QgLywkIHsKCQkJL14+IEFjY2VwdDog
WypdXFwvWypdL2QKCQl9CgkJcy9ePiBDb250ZW50LUxlbmd0aDogLiovPiBDb250ZW50LUxl
bmd0aDogeHh4LwoJCS9ePiAwMC4ud2FudCAvZAoJCS9ePiAwMC4qZG9uZS9kCgoJCS9ePCBT
ZXJ2ZXI6IC9kCgkJL148IEV4cGlyZXM6IC9kCgkJL148IERhdGU6IC9kCgkJL148IENvbnRl
bnQtTGVuZ3RoOiAvZAoJCS9ePCBUcmFuc2Zlci1FbmNvZGluZzogL2QKCSIgPmFjdCAmJgoJ
dGVzdF9jbXAgZXhwIGFjdAoKb2sgMyAtIGNsb25lIGh0dHAgcmVwb3NpdG9yeQoKZXhwZWN0
aW5nIHN1Y2Nlc3M6IAoJZWNobyBjb250ZW50ID4+ZmlsZSAmJgoJZ2l0IGNvbW1pdCAtYSAt
bSB0d28gJiYKCWdpdCBwdXNoIHB1YmxpYwoJKGNkIGNsb25lICYmIGdpdCBwdWxsKSAmJgoJ
dGVzdF9jbXAgZmlsZSBjbG9uZS9maWxlCgpbbWFzdGVyIGFjZTQ4ODFdIHR3bwogQXV0aG9y
OiBBIFUgVGhvciA8YXV0aG9yQGV4YW1wbGUuY29tPgogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspClRvIC9ob21lL2l0b2Rvcm9za2kvZ2l0L3QvdHJhc2ggZGlyZWN0b3J5LnQ1
NTUxLWh0dHAtZmV0Y2gvaHR0cGQvd3d3L3JlcG8uZ2l0CiAgIGJhMzY1NDAuLmFjZTQ4ODEg
IG1hc3RlciAtPiBtYXN0ZXIKRnJvbSBodHRwOi8vMTI3LjAuMC4xOjU1NTEvc21hcnQvcmVw
bwogICBiYTM2NTQwLi5hY2U0ODgxICBtYXN0ZXIgICAgIC0+IG9yaWdpbi9tYXN0ZXIKVXBk
YXRpbmcgYmEzNjU0MC4uYWNlNDg4MQpGYXN0LWZvcndhcmQKIGZpbGUgfCAgICAxICsKIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQpvayA0IC0gZmV0Y2ggY2hhbmdlcyB2aWEg
aHR0cAoKZXhwZWN0aW5nIHN1Y2Nlc3M6IAoJc2VkIC1lICIKCQlzL14uKiBcIi8vCgkJcy9c
Ii8vCgkJcy8gWzEtOV1bMC05XSpcJC8vCgkJcy9eR0VUIC9HRVQgIC8KCSIgPmFjdCA8IiRI
VFRQRF9ST09UX1BBVEgiL2FjY2Vzcy5sb2cgJiYKCXRlc3RfY21wIGV4cCBhY3QKCm9rIDUg
LSB1c2VkIHVwbG9hZC1wYWNrIHNlcnZpY2UKCmV4cGVjdGluZyBzdWNjZXNzOiAKCWdpdCBj
bG9uZSAkSFRUUERfVVJML3NtYXJ0LXJlZGlyLXBlcm0vcmVwby5naXQgLS1xdWlldCByZXBv
LXAKCmVycm9yOiBSUEMgZmFpbGVkOyByZXN1bHQ9MjIsIEhUVFAgY29kZSA9IDQwNQpmYXRh
bDogVGhlIHJlbW90ZSBlbmQgaHVuZyB1cCB1bmV4cGVjdGVkbHkKbm90IG9rIC0gNiBmb2xs
b3cgcmVkaXJlY3RzICgzMDEpCiMJCiMJCWdpdCBjbG9uZSAkSFRUUERfVVJML3NtYXJ0LXJl
ZGlyLXBlcm0vcmVwby5naXQgLS1xdWlldCByZXBvLXAKIwkK
--------------030205090006010705050507--
