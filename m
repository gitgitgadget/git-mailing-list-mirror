From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] messages: uniform error messages for index write
Date: Mon, 01 Jun 2015 16:01:14 -0700
Message-ID: <xmqqsiab3uf9.fsf@gitster.dls.corp.google.com>
References: <cover.1433166363.git.git@drmicha.warpmail.net>
	<0835711582b9db4ee067f2ea1fb767e0df13c4a0.1433166363.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 01:01:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzYhy-0001Pi-SU
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 01:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbbFAXBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 19:01:22 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36655 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbbFAXBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 19:01:16 -0400
Received: by igbpi8 with SMTP id pi8so73720701igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 16:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4l5EAxh6W1XAcRJNPLBPZutfAZxgUo1UQpC7Sy3LSIM=;
        b=vdymMj1OcZ8ytVJFNlskEBVXw38eZSZ2vi9KdQPdt+3Iant4Jg5O11SlixgjUof22T
         95ShtBgH8oFn1TX6ANZkWQ6bS0QkxYe/6CNsHQOr5Ct3ky7VsE177FCntZcQKywnjehr
         X/VIc+0uJYXSZZKcFE+uvvGGQWHfYaS1nm/aiSYrCaoeaxOKNALv4l6k5aY+pfHFOVh9
         PcKi7hgXO79jVYukgzBBho0bd6Vf4C927aqG/uL7ueC/6t06td1sPsZyP2cAs41hww7L
         kb3bCesw0TX+mucafDR2ZuDwvCIXILhswQycXtU5EXWeYkXKmqnZjiDltRxFXh2g1Ak4
         7kYA==
X-Received: by 10.43.39.208 with SMTP id tn16mr30930633icb.27.1433199676196;
        Mon, 01 Jun 2015 16:01:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id f82sm11367186iod.44.2015.06.01.16.01.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 16:01:15 -0700 (PDT)
In-Reply-To: <0835711582b9db4ee067f2ea1fb767e0df13c4a0.1433166363.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Mon, 1 Jun 2015 15:50:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270478>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> * Leave "temporary" in place and add TRANSLATORS note.
>   It may happen that the index file is writable but not the temporary
>   one.
>
> * Leave pack-write.c alone.
>   It is low level without l10n.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> I am actually a bit torn on the "temporary index" messages. On the one hand
> we should hide technicalities from the user; on the other hand, we should give
> helpful information for debugging.
>
> Maybe "new index" and "temporary index" are really in the same camp? I would
> omit "temporary" in that case, too.

It is true that we never overwrite the file in-place, but instead
create a new file and then rename it to the destiation.  So in that
sense, we are always writing "new index file".

There however indeed is a different kind of "temporary" index
involved, when you are doing "git commit paths" to create a partial
commit.  We populate a pristine (relative to HEAD) index, update the
contents of it with the working tree contents at specified paths in
order to write the tree out, but do not use that index after that.
The real index is updated the same way for the specified paths to
match what was committed, but what was added to the real index
outside the specified paths before the partial commit was made is
all kept in the real index.  The presense of this "temporary" index
is something the end users may have to be aware of, if they want to
peek into the state of the index from inside their hooks, so in that
sense, it may make sense to include the word "temporary" in the
error message in that codepath.
