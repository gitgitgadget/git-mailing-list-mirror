From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/3] index-pack: eliminate recursion in find_unresolved_deltas
Date: Tue, 10 Jan 2012 19:23:47 +0700
Message-ID: <CACsJy8Cz-qWs2wrOYTjDMPjJH0wRQCFy9u6OFVPzn6YV0a6WaQ@mail.gmail.com>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
 <1326081546-29320-3-git-send-email-pclouds@gmail.com> <7vzkdwcys4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 13:24:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkakb-0006vm-QI
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 13:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918Ab2AJMYU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 07:24:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40058 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab2AJMYT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 07:24:19 -0500
Received: by eaad14 with SMTP id d14so2530940eaa.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 04:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BO5dHCreTdFsqviVxpR+/ZVCWNl7PpndzOcCJaXttt0=;
        b=YDWb+8/Fy2v9NuaZQhuY3JFWNUdY7a+xtHIEwdtMcC7pMPq7rnuptmaKbdCoW1kbVK
         MgCiwxcZw6yuEJp2Df9+XFWdqT+PPR2+09a4cAnfi6RRn61fK8JKMeRe+ZZwNpguJuco
         6twztVkE9u4tos7LCzaaxqKA7VxxoK7maqtZg=
Received: by 10.204.128.197 with SMTP id l5mr8760452bks.58.1326198258242; Tue,
 10 Jan 2012 04:24:18 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Tue, 10 Jan 2012 04:23:47 -0800 (PST)
In-Reply-To: <7vzkdwcys4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188246>

2012/1/10 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>
> I find both the original and the updated code rather dense to read wi=
thout
> annotation, but from a cursory look all changes look good.

Maybe I stared at it for too long it seems obvious to me (hence no
further description in commit message). Let me describe it (and put in
commit message later if it makes sense)

Current code already links all bases together in a form of tree, using
struct base_data, with prev_base pointer to point to parent node. The
only problem is that struct base_data is all allocated on stack. So we
need to put all on heap (parse_pack_objects and
fix_unresolved_deltas). After that, it's simple depth-first traversal
where each node also maintains its own state (ofs and ref indices to
iterate over all children nodes).

So we process one node:

 - if it returns a new (child) node (a parent base), we link it to our
tree, then process the new node.
 - if it returns nothing, the node is done, free it. We go back to
parent node and resume whatever it's doing.

and do it until we have no nodes to process.
--=20
Duy
