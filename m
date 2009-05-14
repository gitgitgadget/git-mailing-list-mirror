From: Josh Micich <josh.micich@gmail.com>
Subject: Re: [PATCH 3/3] improved validation of entry type in mktree
Date: Thu, 14 May 2009 15:46:04 -0700
Message-ID: <a644352c0905141546w4193d45aq4940e72bbb4bda1c@mail.gmail.com>
References: <loom.20090514T050424-673@post.gmane.org>
	 <loom.20090514T051052-920@post.gmane.org>
	 <7vd4acxkug.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Josh Micich <josh.micich@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 00:47:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4jiF-0001pH-Vn
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 00:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434AbZENWqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 18:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758991AbZENWqF
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 18:46:05 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:43806 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758155AbZENWqE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 18:46:04 -0400
Received: by yx-out-2324.google.com with SMTP id 3so900281yxj.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xho6n4DYjL6bjjdhxMSRT7ht2iyTKtEwOKOH/h1BQkY=;
        b=xdg3SnUhAl9XQp/0+mQkNYl/7Gu1XAH2Q/j7QF+V28899K/DT1GcGp6n60FAPHL8MR
         dW5ybuNO+0uy+EZeICL1CHCAn+XN6mRNsvLhULRHd6yY2zHpZ+lCTv1naolQhFS7rUC+
         yALFp4MWSO1AM3b6RvteCMpOejWXDz/SUwnjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CgqewJEWwb7Rbeq9Bs7bgyjOE8e03jZ9HO59W1J6IZbIy5r4+InTRaCTCIey7nhx3+
         v9TT6Fr6kMUfugfCXOVgELbd2KaX/9LnN28JhO7/hPG6K82Ed+h2UtAZaj/sqGPdERMo
         NR2J1fUWtfVeXa4MBnPzimppsPO9BRlhld8HU=
Received: by 10.100.141.20 with SMTP id o20mr3775717and.40.1242341164963; Thu, 
	14 May 2009 15:46:04 -0700 (PDT)
In-Reply-To: <7vd4acxkug.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119234>

On Wed, May 13, 2009 at 11:24 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> + =A0 =A0 struct strbuf p_uq =3D STRBUF_INIT;
>> =A0 =A0 =A0 if (line_termination && path[0] =3D=3D '"') {
>> - =A0 =A0 =A0 =A0 =A0 =A0 struct strbuf p_uq =3D STRBUF_INIT;
>
> Why make its lifetime longer even though you do not use it outside of=
 this
> block?

Sorry, no need. Similar confusion cleared up in patch 1.

>> +	enum object_type obj_type =3D sha1_object_info(sha1, NULL);
>> + =A0 =A0 if (obj_type < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!allow_missing) {
>
> This is the other way around; when allow_missing is given you shouldn=
't
> even consult the object database to read it.

I think mktree should verify the object types for objects that are avai=
lable.

=46or example (given that 4b825d is empty tree and e69de2 is empty
blob), mktree should reject the following entries:

100644 blob 4b825dc642cb6eb9a060e54bf8d69288fbee4904	foo
040000 tree e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	bar

I don't think the '--missing' option should cause mktree to accept a
tree which is clearly invalid.

=46urthermore even with '--missing', a tree entry like this should be r=
ejected:
160000 commit e69de29bb2d1d6434b8b29ae775ad8c2e48c5391  foo
