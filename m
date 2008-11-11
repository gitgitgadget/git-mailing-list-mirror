From: "Juan Jose Comellas" <juanjo@comellas.org>
Subject: Re: [RFC] mtn to git conversion script
Date: Tue, 11 Nov 2008 14:40:46 -0200
Message-ID: <1c3be50f0811110840p7dff8972r2a5ef7193a0306c2@mail.gmail.com>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
	 <20080825163530.GJ31114@lavos.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_34829_12416505.1226421646200"
Cc: git@vger.kernel.org, monotone-devel@nongnu.org
To: "Brian Downing" <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 17:42:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzwJf-0007KL-Sn
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 17:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbYKKQku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 11:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbYKKQku
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 11:40:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:4436 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbYKKQku (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 11:40:50 -0500
Received: by fg-out-1718.google.com with SMTP id 19so69985fgg.17
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 08:40:46 -0800 (PST)
Received: by 10.181.226.19 with SMTP id d19mr2558832bkr.35.1226421646211;
        Tue, 11 Nov 2008 08:40:46 -0800 (PST)
Received: by 10.180.242.8 with HTTP; Tue, 11 Nov 2008 08:40:46 -0800 (PST)
In-Reply-To: <20080825163530.GJ31114@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100650>

------=_Part_34829_12416505.1226421646200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I made some modifications to the script that converts Monotone
repositories to Git to make it work with what I had. I also added
support for renaming commit authors.

To use the modified script just call it passing the name of the
repository file as the first argument. You can add a second optional
argument with the name of the file that holds the authors' names and
email addresses. In this file you should have one line per commit
author with the following format:

Firstname Lastname <email@example.com>

This script still uses the AutomateStdio.pm Perl module that can be
found in the net.venge.monotone.contrib.lib.automate-stdio branch of
Monotone's main repository.

I'm no Perl guru so there might be some bugs lurking in the code I
added. It did work for my repositories, though.

PS. Resending because I mistakenly sent the previous message as HTML mail.


On Mon, Aug 25, 2008 at 2:35 PM, Brian Downing <bdowning@lavos.net> wrote:
>
> On Sun, Aug 24, 2008 at 12:18:50PM +0300, Felipe Contreras wrote:
> > I developed a script that converts a monotone repository into a git
> > one (exact clone), I want to contribute it so everybody can use it.
> >
> > This is the gist of the script:
> >
> > mtn update --revision #{@id} --reallyquiet
> > git ls-files --modified --others --exclude-standard -z | git
> > update-index --add --remove -z --stdin
> > git write-tree
> > git write-raw < /tmp/commit.txt
> > git update-ref refs/mtn/#{@id} #{@git_id}
> >
> > branches.each do |e|
> >     git update-ref refs/heads/#{e} #{@git_id}
> > end
>
> You definitely want to use fast-import, but you probably want to do
> something a lot closer to fast-export for monotone (read: use its
> automate stdio interface and avoid expensive calls).
>
> Here's a simple monotone to git converter I wrote.  You'll need the
> Monotone::AutomateStdio perl module to use it (which I think I got it
> from monotone's net.venge.monotone.contrib.lib.automate-stdio branch).
> It is very fast; it can convert the OpenEmbedded repo in something like
> 5-10 minutes on my machine.
>
> Note that for monotone export to go fast you absolutely /must/ avoid the
> get_manifest operation.  In my converter I use the revision information
> directly.  Getting the renames right with this is a little tricky; IIRC,
> the ordering that works is:
>
> * Rename all renamed files, innermost files first, to temporary names.
> * Delete all deleted files, innermost first.
> * Rename all temporary names to permanent names, outermost first.
> * Add all new/modified files.
>
> Conveniently, all of the above can be done by directly emitting
> fast-import commands, so you don't have to keep track of trees directly.
> (With one exception, which I'll elaborate on in a different email.)
>
> -bcd

------=_Part_34829_12416505.1226421646200
Content-Type: text/x-perl; name=mtn-to-git.pl
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fnern58u1
Content-Disposition: attachment; filename=mtn-to-git.pl

IyEvdXNyL2Jpbi9wZXJsCiMgQ29weXJpZ2h0IChDKSAyMDA3LTIwMDggIEJyaWFuIERvd25pbmcK
IyBUaGlzIHByb2dyYW0gaXMgbGljZW5zZWQgdW5kZXIgdmVyc2lvbiAyIG9mIHRoZSBHTlUgR1BM
LgoKdXNlIHN0cmljdDsKdXNlIE1vbm90b25lOjpBdXRvbWF0ZVN0ZGlvOwp1c2UgRGF0ZTo6UGFy
c2U7CgpteSAkRCA9IDA7CgpteSAkbSA9IE1vbm90b25lOjpBdXRvbWF0ZVN0ZGlvLT5uZXcoJEFS
R1ZbMF0pOwoKbXkgJHJldmxpc3QgPSBbXTsKJG0tPmdyYXBoKCRyZXZsaXN0KTsKbXkgJHNvcnRl
ZCA9IFtdOwoKZm9yIG15ICRyZXYgKEAkcmV2bGlzdCkgewogICAgcHVzaChAJHNvcnRlZCwgJHJl
di0+e3JldmlzaW9uX2lkfSk7Cn0KCm15ICRsZWF2ZXMgPSBbXTsKJG0tPmxlYXZlcygkbGVhdmVz
KTsKCiRtLT50b3Bvc29ydCgkc29ydGVkLCBAJHNvcnRlZCk7CgpteSAkbWFya3MgPSB7fTsKbXkg
JG1hcmsgPSAxOwpteSAkYyA9IDA7Cm15ICVhdXRob3JzID0ge307CgpzdWIgcXVvdGVfZmlsZSB7
CiAgICAkXyA9IHNoaWZ0OwogICAgcmV0dXJuICRfOwogICAgcy9cXC9cXFxcL2c7CiAgICBzL1xu
L1xcbi9nOwogICAgcy8iL1xcIi9nOwogICAgcmV0dXJuIHFxKCIkXyIpOwp9CgpzdWIgbHByaW50
IHsKICAgIG15ICRmaCA9IHNoaWZ0OwogICAgcHJpbnQgQF8gaWYgJEQ7CiAgICBwcmludCAkZmgg
QF87Cn0KCnN1YiBscHJpbnRmIHsKICAgIG15ICRmaCA9IHNoaWZ0OwogICAgcHJpbnRmIEBfIGlm
ICREOwogICAgcHJpbnRmICRmaCBAXzsKfQoKc3ViIGxvYWRfYXV0aG9ycyB7CiAgICBteSAlYXV0
aG9ycyA9ICgpOwogICAgbXkgJGZpbGVuYW1lID0gc2hpZnQoQF8pOwogICAgb3BlbiBteSAkZmks
ICc8JywgJGZpbGVuYW1lIG9yIGRpZSAiQ291bGQgbm90IG9wZW4gYXV0aG9ycyBtYXAgZmlsZSAk
ZmlsZW5hbWVcbiI7IAogICAgZm9yIG15ICRsaW5lICg8JGZpPikgewogICAgICAgIGlmICgkbGlu
ZSA9fiBtLyguKikgPCguKik+LykgewogICAgICAgICAgICBpZiAoJDIpIHsKICAgICAgICAgICAg
ICAgICRhdXRob3JzeyQyfSA9ICQxOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgfQogICAg
cmV0dXJuICVhdXRob3JzOwp9CgpzdWIgYXV0aG9yX25hbWUgewogICAgbXkgJGVtYWlsID0gc2hp
ZnQoQF8pOwogICAgbXkgJG5hbWUgPSAkYXV0aG9yc3skZW1haWx9OwogICAgaWYgKCRuYW1lKSB7
CiAgICAgICAgcmV0dXJuICRuYW1lOwogICAgfSBlbHNlIHsKICAgICAgICBpZiAoJGVtYWlsID1+
IG0vKC4rKVxALisvKSB7CiAgICAgICAgICAgIHJldHVybiAkMTsKICAgICAgICB9IGVsc2Ugewog
ICAgICAgICAgICByZXR1cm4gJGVtYWlsOwogICAgICAgIH0KICAgIH0KfQoKbXkgJHRtcHRhZyA9
ICI2MjRkODkzZS1hZTFhLTQyZDgtOTBhOS05MjZhNmNlZmZhZTgiOwoKaWYgKCRBUkdWWzFdKSB7
CiAgICAlYXV0aG9ycyA9IGxvYWRfYXV0aG9ycygkQVJHVlsxXSk7Cn0gZWxzZSB7CiAgICAlYXV0
aG9ycyA9IHt9Owp9Cm9wZW4gbXkgJGZpLCAnfC0nLCAnZ2l0LWZhc3QtaW1wb3J0IC0tZXhwb3J0
LW1hcmtzPWZpbGUnOwojIG9wZW4gbXkgJGZpLCAnPmZhc3QtaW1wb3J0LmR1bXAnOwpiaW5tb2Rl
ICRmaTsKZm9yIG15ICRyZXYgKEAkc29ydGVkKSB7CiAgICBteSAoJHRpbWUsICRhdXRob3IsICRt
c2cpID0gKCIwIiwgIl9fVU5LTk9XTl9fIiwgIl9fVU5LTk9XTl9fIik7CiAgICBteSBAY2VydHM7
CiAgICBteSBAYnJhbmNoZXM7CiAgICAkbS0+Y2VydHMoXEBjZXJ0cywgJHJldik7CiAgICBmb3Ig
bXkgJGNlcnQgKEBjZXJ0cykgewogICAgICAgIG15ICgkbiwgJHYpID0gKCRjZXJ0LT57bmFtZX0s
ICRjZXJ0LT57dmFsdWV9KTsKICAgICAgICAkYXV0aG9yID0gJHYgaWYgKCRuIGVxICdhdXRob3In
KTsKICAgICAgICAkdGltZSA9ICR2IGlmICgkbiBlcSAnZGF0ZScpOwogICAgICAgICRtc2cgPSAk
diBpZiAoJG4gZXEgJ2NoYW5nZWxvZycpOwogICAgICAgIHB1c2goQGJyYW5jaGVzLCAkdikgaWYg
KCRuIGVxICdicmFuY2gnKTsKICAgIH0KICAgIG15ICRlbWFpbCA9ICRhdXRob3I7CiAgICAkbXNn
IC49ICJcbm10bi1yZXZpc2lvbjogJHJldlxuIjsKICAgIGZvciBteSAkYiAoc29ydCBAYnJhbmNo
ZXMpIHsKICAgICAgICAkbXNnIC49ICJtdG4tYnJhbmNoOiAkYlxuIjsKICAgIH0KICAgICR0aW1l
ID0gc3RyMnRpbWUoJHRpbWUsICdVVEMnKTsKICAgIG15ICRtZmVzdCA9IFtdOwogICAgJG0tPmdl
dF9yZXZpc2lvbigkbWZlc3QsICRyZXYpOwogICAgbXkgJG9yY291bnQgPSAwOwogICAgbXkgJGFk
ZF9maWxlcyA9IHt9OwogICAgbXkgJGFkZF9kaXJzID0ge307CiAgICBteSAkZGVsZXRlX2ZpbGVz
ID0ge307CiAgICBteSAkZnJvbV90bXBuYW1lcyA9IHt9OwogICAgbXkgJHRvX3RtcG5hbWVzID0g
e307CiAgICBteSAkY3VydG1wID0gMDsKICAgIG15IEBwYXJlbnRzOwogICAgZm9yIG15ICRlIChA
JG1mZXN0KSB7CiAgICAgICAgaWYgKCRlLT57dHlwZX0gZXEgJ29sZF9yZXZpc2lvbicpIHsKICAg
ICAgICAgICAgcHVzaChAcGFyZW50cywgJGUtPntyZXZpc2lvbl9pZH0pOwogICAgICAgICAgICAr
KyRvcmNvdW50OwogICAgICAgIH0gCiAgICAgICAgbmV4dCBpZiAkb3Jjb3VudCA+IDE7CiAgICAg
ICAgaWYgKCRlLT57dHlwZX0gZXEgJ2FkZF9maWxlJyB8fCAkZS0+e3R5cGV9IGVxICdwYXRjaCcp
IHsKICAgICAgICAgICAgbXkgJGlkID0gJGUtPntmaWxlX2lkfSB8fCAkZS0+e3RvX2ZpbGVfaWR9
OwogICAgICAgICAgICAkYWRkX2ZpbGVzLT57JGUtPntuYW1lfX0gPSAkaWQ7CiAgICAgICAgICAg
IHVubGVzcyAoJG1hcmtzLT57JGlkfSkgewogICAgICAgICAgICAgICAgbXkgJGRhdGE7CiAgICAg
ICAgICAgICAgICAkbS0+Z2V0X2ZpbGUoXCRkYXRhLCAkaWQpOwogICAgICAgICAgICAgICAgcHJp
bnQgIm5ldyBmaWxlICRpZFxuIiBpZiAkRDsKICAgICAgICAgICAgICAgIHByaW50ICRmaSAiYmxv
YlxuIjsKICAgICAgICAgICAgICAgIG15ICRsZW4gPSBsZW5ndGgoJGRhdGEpOwogICAgICAgICAg
ICAgICAgcHJpbnQgJGZpICJtYXJrIDokbWFya1xuIjsKICAgICAgICAgICAgICAgICRtYXJrcy0+
eyRpZH0gPSAkbWFyaysrOwogICAgICAgICAgICAgICAgcHJpbnQgJGZpICJkYXRhICRsZW5cbiRk
YXRhXG4iOwogICAgICAgICAgICAgICAgI3ByaW50ICRmaSAiZGF0YSAkbGVuXG4iOwogICAgICAg
ICAgICAgICAgI3ByaW50ICRmaSBwYWNrKCdDJywgJGRhdGEpOwogICAgICAgICAgICAgICAgI3By
aW50ICRmaSAiXG4iOwogICAgICAgICAgICB9CiAgICAgICAgfSBlbHNpZiAoJGUtPnt0eXBlfSBl
cSAnYWRkX2RpcicpIHsKICAgICAgICAgICAgJGFkZF9kaXJzLT57JGUtPntuYW1lfX0gPSAxOwog
ICAgICAgIH0gZWxzaWYgKCRlLT57dHlwZX0gZXEgJ2RlbGV0ZScpIHsKICAgICAgICAgICAgJGRl
bGV0ZV9maWxlcy0+eyRlLT57bmFtZX19ID0gMTsKICAgICAgICB9IGVsc2lmICgkZS0+e3R5cGV9
IGVxICdyZW5hbWUnKSB7CiAgICAgICAgICAgICRjdXJ0bXArKzsKICAgICAgICAgICAgJGZyb21f
dG1wbmFtZXMtPnskZS0+e2Zyb21fbmFtZX19ID0gIl9fdG1wXyR7dG1wdGFnfV8kY3VydG1wIjsK
ICAgICAgICAgICAgJHRvX3RtcG5hbWVzLT57JGUtPnt0b19uYW1lfX0gPSAiX190bXBfJHt0bXB0
YWd9XyRjdXJ0bXAiOwogICAgICAgIH0KICAgIH0KICAgIHByaW50ZigicmV2ICRyZXYgKCVkLyVk
LCAlLjJmJSlcbiIsCiAgICAgICAgICAgKyskYywgc2NhbGFyKEAkc29ydGVkKSwgMTAwKiRjL3Nj
YWxhcihAJHNvcnRlZCkpOwogICAgcHJpbnQgJGZpICJyZXNldCByZWZzL2ltcG9ydFxuIiB1bmxl
c3MgQHBhcmVudHM7CiAgICBscHJpbnQgJGZpLCAiY29tbWl0IHJlZnMvaW1wb3J0XG4iOwogICAg
cHJpbnQgJGZpICJtYXJrIDokbWFya1xuIjsKICAgICRtYXJrcy0+eyRyZXZ9ID0gJG1hcmsrKzsK
ICAgIGlmICgkYXV0aG9yID1+IG0oXHMqKC4qP1xTKVxzKjwoLiopPlxzKikpIHsKICAgICAgICAj
ICRhdXRob3IgPSAkMTsKICAgICAgICAkZW1haWwgPSAkMjsKICAgIH0KICAgICMgJGF1dGhvciA9
fiBzL1s8Pl0vXy9nOwogICAgJGVtYWlsID1+IHMvWzw+XS9fL2c7CiAgICAjICRhdXRob3IgPX4g
cy9ALiovLzsKICAgICRhdXRob3IgPSBhdXRob3JfbmFtZSgkZW1haWwpOwogICAgcHJpbnQgJGZp
ICJjb21taXR0ZXIgJGF1dGhvciA8JGVtYWlsPiAkdGltZSArMDAwMFxuIjsKICAgIG15ICRsZW4g
PSBsZW5ndGgoJG1zZyk7CiAgICBwcmludCAkZmkgImRhdGEgJGxlblxuJG1zZ1xuIjsKICAgIG15
ICRmcm9tID0gImZyb20iOwogICAgZm9yIG15ICRwIChAcGFyZW50cykgewogICAgICAgICMgbHBy
aW50ICRmaSwgIiRmcm9tIDokbWFya3MtPnskcH1cbiI7CiAgICAgICAgbXkgJHBhcmVudF9tYXJr
ID0gJG1hcmtzLT57JHB9OwogICAgICAgIGlmICgkcGFyZW50X21hcmspIHsKICAgICAgICAgICAg
bHByaW50ICRmaSwgIiRmcm9tIDokcGFyZW50X21hcmtcbiI7CiAgICAgICAgICAgICRmcm9tID0g
Im1lcmdlIjsKICAgICAgICB9CiAgICB9CiAgICBmb3IgbXkgJGYgKHNvcnQgeyBsZW5ndGgoJGIp
IDw9PiBsZW5ndGggKCRhKSB9IGtleXMgJSRmcm9tX3RtcG5hbWVzKSB7CiAgICAgICAgbHByaW50
ZigkZmksICJSICVzICVzXG4iLAogICAgICAgICAgICAgICAgcXVvdGVfZmlsZSgkZiksIHF1b3Rl
X2ZpbGUoJGZyb21fdG1wbmFtZXMtPnskZn0pKTsKICAgIH0KICAgIGZvciBteSAkZiAoc29ydCB7
IGxlbmd0aCgkYikgPD0+IGxlbmd0aCAoJGEpIH0ga2V5cyAlJGRlbGV0ZV9maWxlcykgewogICAg
ICAgIGxwcmludGYoJGZpLCAiRCAlc1xuIiwgcXVvdGVfZmlsZSgkZikpOwogICAgfQogICAgZm9y
IG15ICRmIChzb3J0IHsgbGVuZ3RoKCRhKSA8PT4gbGVuZ3RoICgkYikgfSBrZXlzICUkdG9fdG1w
bmFtZXMpIHsKICAgICAgICBscHJpbnRmKCRmaSwgIlIgJXMgJXNcbiIsCiAgICAgICAgICAgICAg
ICBxdW90ZV9maWxlKCR0b190bXBuYW1lcy0+eyRmfSksIHF1b3RlX2ZpbGUoJGYpKTsKICAgIH0K
ICAgIGZvciBteSAkZiAoa2V5cyAlJGFkZF9maWxlcykgewogICAgICAgIGxwcmludGYoJGZpLCAi
TSAwNjQ0IDolcyAlc1xuIiwKICAgICAgICAgICAgICAgICRtYXJrcy0+eyRhZGRfZmlsZXMtPnsk
Zn19LCBxdW90ZV9maWxlKCRmKSk7CiAgICB9CiAgICBmb3IgbXkgJGYgKGtleXMgJSRhZGRfZGly
cykgewogICAgICAgICRmIC49ICIvIiBpZiAkZjsKICAgICAgICBscHJpbnRmKCRmaSwgIk0gMDY0
NCBpbmxpbmUgJXNcbiIsIHF1b3RlX2ZpbGUoIiRmLmdpdGlnbm9yZSIpKTsKICAgICAgICBscHJp
bnQoJGZpLCAiZGF0YSAwXG5cbiIpOwogICAgfQogICAgcHJpbnQgJGZpICJcbiI7Cn0KCm15ICRi
cmFuY2hlcyA9IHt9Owpmb3IgbXkgJHJldiAoQCRsZWF2ZXMpIHsKICAgIG15ICRicmFuY2g7CiAg
ICBteSBAY2VydHM7CiAgICAkbS0+Y2VydHMoXEBjZXJ0cywgJHJldik7CiAgICBmb3IgbXkgJGNl
cnQgKEBjZXJ0cykgewogICAgICAgIG15ICgkbiwgJHYpID0gKCRjZXJ0LT57bmFtZX0sICRjZXJ0
LT57dmFsdWV9KTsKICAgICAgICAkYnJhbmNoID0gJHYgaWYgKCRuIGVxICdicmFuY2gnKTsKICAg
IH0KICAgIG15ICRyID0gJGJyYW5jaGVzLT57JGJyYW5jaH07CiAgICAkYnJhbmNoZXMtPnskYnJh
bmNofS0tOwogICAgaWYgKCRtYXJrcy0+eyRyZXZ9KSB7CiAgICAgICAgcHJpbnQgJGZpICJyZXNl
dCByZWZzL2hlYWRzLyRicmFuY2gkclxuIjsKICAgICAgICBwcmludCAkZmkgImZyb20gOiRtYXJr
cy0+eyRyZXZ9XG5cbiI7CiAgICB9Cn0KCmNsb3NlICRmaTsK
------=_Part_34829_12416505.1226421646200--
