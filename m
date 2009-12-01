From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] get_ref_states: strdup entries and free util in stale 
	list
Date: Tue, 1 Dec 2009 19:20:55 +0100
Message-ID: <36ca99e90912011020u4bcc8802qd12049969d162c97@mail.gmail.com>
References: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com>
	 <alpine.DEB.1.00.0912010934120.4985@pacific.mpi-cbg.de>
	 <36ca99e90912010105r428a7bfdw63928e8a5515bd1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 01 19:21:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFXLR-0002tr-L2
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 19:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbZLASUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 13:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbZLASUu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 13:20:50 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:36359 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbZLASUt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 13:20:49 -0500
Received: by fxm5 with SMTP id 5so5222917fxm.28
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 10:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=mazoVnJA7HyjXmeMff9wbDrqM79yX8NkpKOd5dloGq8=;
        b=sOkgngcy5gj/AAYerkx+wekrVff/uOny9jZNdzezKEPYHRV2tihRwIfeVlD9dULc96
         lphHa3Py3f9iYaDKqKnKHXKYnID6rcRyZUYNSXqhmfNqwegBSP04/n8jnyIVSb2IZLhc
         RRMYcB0vC9mLVYcYLCpVZEXLLuy73jNHEgVH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=efyGj3QNnyYZY5xyFeQ7MgCcY+l+iWHl8wjD1r9FN64FasTgEPQi2T2rjRymqvFolL
         eLMsR7nZnwZFhBJKDC+un+t8kHHEbXcZOpXG0XIwPGCGoxLtBB/oAswxyYeKcqV37UXU
         LBCKCcsQPVdrXtw0Ic/q4R9ayd8zxps0OBGcM=
Received: by 10.223.68.155 with SMTP id v27mr925919fai.10.1259691655108; Tue, 
	01 Dec 2009 10:20:55 -0800 (PST)
In-Reply-To: <36ca99e90912010105r428a7bfdw63928e8a5515bd1d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134240>

On Tue, Dec 1, 2009 at 10:05, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> There are still invalid reads of size 4. I think the problem is the
> flex array member of 'struct ref' and strlen(). If its worth I can
> look into this.
A short heads-up, here is the valgrind error I get for this invalid read:

==27305== Invalid read of size 4
==27305==    at 0x4936AF: copy_ref (remote.c:870)
==27305==    by 0x4942E4: get_fetch_map (remote.c:1271)
==27305==    by 0x44473E: get_remote_ref_states (builtin-remote.c:271)
==27305==    by 0x446DCE: cmd_remote (builtin-remote.c:1022)
==27305==    by 0x4045F0: handle_internal_command (git.c:257)
==27305==    by 0x404B8F: main (git.c:482)
==27305==  Address 0x5b5ba38 is 104 bytes inside a block of size 107 alloc'd
==27305==    at 0x4C24477: calloc (vg_replace_malloc.c:418)
==27305==    by 0x4B09AD: xcalloc (wrapper.c:75)
==27305==    by 0x493924: alloc_ref_with_prefix (remote.c:853)
==27305==    by 0x46653B: get_remote_heads (connect.c:96)
==27305==    by 0x4A9347: get_refs_via_connect (transport.c:453)
==27305==    by 0x4A7F14: transport_get_remote_refs (transport.c:895)
==27305==    by 0x4445B6: get_remote_ref_states (builtin-remote.c:810)
==27305==    by 0x446DCE: cmd_remote (builtin-remote.c:1022)
==27305==    by 0x4045F0: handle_internal_command (git.c:257)
==27305==    by 0x404B8F: main (git.c:482)
