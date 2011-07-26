From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: long fast-import errors out "failed to apply delta"
Date: Wed, 27 Jul 2011 03:09:41 +0600
Message-ID: <CA+gfSn8-+X9vrCYamN9Rg-PnGAQ3u5jH+S7LYxoZopMyEF9VPg@mail.gmail.com>
References: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
	<CA+gfSn8C-nB2hSSRTqSu1N1Z-b8ctRsVmUGAjLXTW0du_W3EQw@mail.gmail.com>
	<CA+gfSn8m=_vd91Xe5EnFXUvZnuJf-yUE6H7FU+ak8S8a+NtCjA@mail.gmail.com>
	<20110726165858.GA2334@elie.dc0b.debconf.org>
	<CA+gfSn-ZhqXfTELg_LfMJhMW7L7GVBoRTwZO_+QYntLrh+rk0Q@mail.gmail.com>
	<20110726185504.GA2398@elie.dc0b.debconf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 23:09:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlost-0007Wm-1z
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 23:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab1GZVJn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 17:09:43 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46248 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab1GZVJm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 17:09:42 -0400
Received: by qwk3 with SMTP id 3so487706qwk.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8J2wrFYoaupdR/nFw23mgRmqJHKDFY6aqsCqT1P3UT4=;
        b=t2EHR2eL1hWYbC3Frx8J/8NnQJJMwthF+aLW+9GeqaB0iJTtt4MJ3St7x9JWBnSZvB
         8QHo+k5zRaZWMnva7qSNdnmNAoMMku468mFqh05ubh/G2CE1TVdX5HRB/IWi2NfJCAKr
         nu4WZv79w6VAWQF+PAAWDQqf1c35Zy23kEy6w=
Received: by 10.229.1.67 with SMTP id 3mr1007806qce.150.1311714581198; Tue, 26
 Jul 2011 14:09:41 -0700 (PDT)
Received: by 10.229.189.3 with HTTP; Tue, 26 Jul 2011 14:09:41 -0700 (PDT)
In-Reply-To: <20110726185504.GA2398@elie.dc0b.debconf.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177901>

On Wed, Jul 27, 2011 at 12:55 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Dmitry Ivankov wrote:
>> On Tue, Jul 26, 2011 at 10:58 PM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
>
>>> Could you save the svn-fe output (e.g., by introducing "tee" in the
>>> middle of the "svn-fe | fast-import" pipeline) and put it up
>>> somewhere online? =A0This would also be a good starting point for c=
oming
>>> up with a reduced testcase.
>>
>> It's 1.9G uncompressed, 0.7G lzo-compressed. Will setup a ftp or
>> torrent seed a bit later.
>
> Ah, never mind then. :) =A0Do you have a script to reproduce it?
I've uploaded the compressed svnadmin dump to dropbox - it's just 15M.
So here is a Makefile to reproduce the bug.
It needs svn-fe using deltas and fast-import knowing cat-blob-fd, cat-b=
lob, ls.
But once gcc.fi_stream is built, any more or less recent fast-import
can be used.

bug: gcc.fi_stream gcc.fi_stream_more
        rm -rf tmp && \
        git init --bare tmp && \
        cat gcc.fi_stream gcc.fi_stream_more | \
        GIT_DIR=3Dtmp git fast-import 2>&1 >/dev/null && \
        GIT_DIR=3Dtmp git fsck
gcc.svndump.tar.bz2:
        wget http://dl.dropbox.com/u/36429197/gcc.svndump.tar.bz2
gcc.svndump: gcc.svndump.tar.bz2
        tar xjpf $<
        #command -v svnrdump && \
        #svnrdump dump -r0:15507 svn://gcc.gnu.org/svn/gcc >gcc.svndump
        #|| rm -f gcc.svndump
gcc.fi_stream: gcc.svndump
        command -v svn-fe && \
        rm -f backflow && \
        mkfifo backflow && \
        rm -rf tmp && \
        git init --bare tmp && \
        cat gcc.svndump | svn-fe 3<backflow | tee gcc.fi_stream | \
        GIT_DIR=3Dtmp git fast-import --cat-blob-fd=3D3 3>backflow 2>&1=
 >/dev/null \
        || rm -f gcc.fi_stream
gcc.fi_stream_more:
        echo "commit refs/heads/master" >$@
        echo "mark :15508" >>$@
        echo "committer nobody
<nobody@69586fb2-bf4f-e74e-8260-21e4b08243f9> 874511505 +0000" >>$@
        echo "data 71" >>$@
        echo "This commit was manufactured by cvs2svn to create tag" >>=
$@
        echo "'egcs_ss_970917'." >>$@
        echo "#ls :14842 branches/gcc3/gcc/config" >>$@
        echo "M 040000 fbc83f80e9516c831918dff149058cba38a2e5f1
tags/egcs_ss_970917/gcc/config" >>$@
        echo "#ls :15459 trunk/gcc/config/alpha" >>$@
        echo "M 040000 9ffe84c346eec93b523d95ce642b54d54d23109c
tags/egcs_ss_970917/gcc/config/alpha" >>$@
        echo "#ls \"tags/egcs_ss_970917/gcc/config/alpha\"" >>$@
        echo "M 100644 inline
tags/egcs_ss_970917/gcc/config/alpha/vms-tramp.asm_" >>$@
        echo "data <<EOF" >>$@
        echo "123" >>$@
        echo "EOF" >>$@
        echo "progress Imported commit 15508" >>$@
=2EPHONY: bug
