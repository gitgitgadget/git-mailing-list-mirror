From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: My custom cccmd
Date: Sun, 25 Oct 2009 17:04:44 +0200
Message-ID: <94a0d4530910250804w3a7da36eke10710eb1cbb03c1@mail.gmail.com>
References: <94a0d4530910150620g733bdf0aq88660053f869b0a9@mail.gmail.com>
	 <7vk4yw4dy3.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910151437s780bd96anca82d2b26ef99e0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 16:05:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N24ex-0003xm-Dx
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbZJYPEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2009 11:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbZJYPEl
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:04:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:29057 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbZJYPEk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 11:04:40 -0400
Received: by fg-out-1718.google.com with SMTP id 16so4590833fgg.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C9FbKGOMDAXaaYNJfIonXMFPqwNr40qfKke0Owk+7Rk=;
        b=NfnoHKvkHG4b3cYHsAnvW1C4MEsIJqpuuMh3A/1/qw4rQdw1sPSBm6Wd+HbC5n2e51
         FG4wI4uf5ipj438fDcx8bYScvij8RvUr0P9SPUZoEstUOLM0MtxSv+JZdFTgH0O4XEh1
         k/y0npOK13Lnzgx781EhofUl05FByqgsFuRTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cvLZYPbETf9ozB2JiEmJKT99vmYONLVZrH30YbKSLDgzyF0vvMZfBCz6agw3GJKvgV
         u4uya0d8fs4tqpnIWjyKFZsHE77cpiqYxgovqArY+IPEBZv+IqEvTa+khmxdKX6kDRKk
         wRICY4+PP08KAYaASzJjB36+8DQsabObnYk3I=
Received: by 10.87.69.28 with SMTP id w28mr7005865fgk.46.1256483084684; Sun, 
	25 Oct 2009 08:04:44 -0700 (PDT)
In-Reply-To: <94a0d4530910151437s780bd96anca82d2b26ef99e0a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131206>

On Thu, Oct 15, 2009 at 11:37 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Oct 15, 2009 at 11:09 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> =C2=A0#2. If you have two patch series that updates one file twice, =
some
>> =C2=A0 =C2=A0 changes in your second patch could even be an update t=
o the changes
>> =C2=A0 =C2=A0 you introduced in your first patch. =C2=A0After you fi=
x issue #1, you
>> =C2=A0 =C2=A0 would probably want to fix this by excluding the commi=
ts you have
>> =C2=A0 =C2=A0 already sent the blames for.
>
> How exactly? By looking at the commit from 'git blame' and discarding
> it? That would be a bit tricky since each instance of 'cccmd' is not
> aware of the previous ones.

I explored this a bit more and I've come to the conclusion that we
actually don't wand to discard the previous commits in the patch
series. Let's think about this example:
0001 <- John
0002 <- Me overriding some changes from John

In this case we want John to appear in the CC list of 0002, because we
are changing his code. If it turns out that the whole patch series was
written by me, it's still ok for me to appear on the CC list, which
would essentially be "discarding" those commits.

So all we need to do is pick @from^ as the base of the git blame:
@@ -17,11 +17,12 @@ end
 ARGV.each do |filename|
   patch_file =3D File.open(filename)
   patch_file.each_line do |patch_line|
+    @from ||=3D patch_line[/From (\w+)/, 1]
     case patch_line
     when /^---\s+(\S+)/
       @source =3D $1[2..-1]
     when /^@@\s-(\d+),(\d+)/
-      blame =3D `git blame -p -L #{$1},+#{$2} #{@source} | grep author=
`
+      blame =3D `git blame --incremental -L #{$1},+#{$2} #{@source}
#{@from}^ | grep author`
       blame.each_line { |l| parse_blame(l.chomp) }
     end
   end

You can find the whole script here:
http://gist.github.com/218093

Cheers.

--=20
=46elipe Contreras
