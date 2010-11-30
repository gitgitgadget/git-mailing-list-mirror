From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: Git Gui does not want to work on chunk level
Date: Tue, 30 Nov 2010 23:20:03 +0100
Message-ID: <AANLkTikd84--37+vcoHifqFeUGznEQ9YXDaY3a3zOekn@mail.gmail.com>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com>
	<c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com>
	<20080903230814.GJ28315@spearce.org>
	<c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com>
	<20080904143723.GB23708@spearce.org>
	<c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com>
	<20080905045327.GA31166@spearce.org>
	<48CE09EF.7090609@viscovery.net>
	<AANLkTimz17vodjS7K_ts2pcoZHTo2eb9=FaWwEyhihsa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 30 23:20:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNYYd-0004A7-S1
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 23:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab0K3WUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Nov 2010 17:20:06 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34623 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab0K3WUF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Nov 2010 17:20:05 -0500
Received: by ywl5 with SMTP id 5so3038720ywl.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 14:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=THUXxzmp762N4CUAK4IIOQn3a2iRoCTF1BmeOOsnB5M=;
        b=X2MS22vb42RZvmjyFFnH0IrP46mMEzrhsuJe0RW8blT+q2jh1Jngf25MoHFXa9LzlM
         UVGFHHvYjoPDzvhvjPdhUTPywCy+nTqboZm/rxDOTmh1WWc3zaZ/7CCI20G/pGWbG+av
         93NBd9f2MVOOhnjwJpllyxIC/bIjq7AbqolCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xkwFBWqboI3/N9DkSbRxdtzKRHlvgd9Id89Y5RfQ5/6QUvrsc5i0Me/HCE16UbyI7U
         rehB8YU2o1F4PTw74UF3ddQ/y9k5OomXB7jZlIQEB5jIQ10VyzShBePEpHOuCXyliSjD
         fihmvATdv5UUoX3stqbVPtBHfrH4As8xVLLz8=
Received: by 10.42.222.200 with SMTP id ih8mr2281570icb.23.1291155603918; Tue,
 30 Nov 2010 14:20:03 -0800 (PST)
Received: by 10.42.175.71 with HTTP; Tue, 30 Nov 2010 14:20:03 -0800 (PST)
In-Reply-To: <AANLkTimz17vodjS7K_ts2pcoZHTo2eb9=FaWwEyhihsa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162490>

On Tue, Nov 30, 2010 at 22:19, Bert Wesarg <bert.wesarg@googlemail.com>=
 wrote:
> On Mon, Sep 15, 2008 at 09:08, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
>> =C2=A0new file mode 100644
>> =C2=A0--- /dev/null
>> =C2=A0+++ b/foo
>> =C2=A0@@ -0,0 +1 @@
>> =C2=A0+foo
>
> I just noticed the same, and ask me why this report wasn't honored.
>
> Also git may spill out 2 diffs for type changes (file to symlink, for
> example). In this case the we should probably disable any hunk- or
> line-level (un)staging.

Here is a proposal which fixes this case. Not tested on the OPs report.

--8<--
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 8fea947..b3901c3 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -398,7 +398,6 @@ proc read_diff {fd conflict_size cont_info} {
 		if {$line eq {deleted file mode 120000}} {
 			set line "deleted symlink"
 		}
-		set ::current_diff_inheader 0

 		# -- Automatically detect if this is a 3 way diff.
 		#
@@ -414,6 +413,7 @@ proc read_diff {fd conflict_size cont_info} {
 			|| [regexp {^\* Unmerged path } $line]} {
 			set tags {}
 		} elseif {$is_3way_diff} {
+			set ::current_diff_inheader 0
 			set op [string range $line 0 1]
 			switch -- $op {
 			{  } {set tags {}}
@@ -440,6 +440,7 @@ proc read_diff {fd conflict_size cont_info} {
 			}
 			}
 		} elseif {$is_submodule_diff} {
+			set ::current_diff_inheader 0
 			if {$line =3D=3D ""} continue
 			if {[regexp {^Submodule } $line]} {
 				set tags d_@
@@ -459,6 +460,7 @@ proc read_diff {fd conflict_size cont_info} {
 				}
 			}
 		} else {
+			set ::current_diff_inheader 0
 			set op [string index $line 0]
 			switch -- $op {
 			{ } {set tags {}}
