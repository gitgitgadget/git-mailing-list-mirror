From: Junio C Hamano <gitster@pobox.com>
Subject: Re: repository corruption when pushing commits to a repository running 'git gc --prune='
Date: Wed, 14 Oct 2015 13:05:36 -0700
Message-ID: <xmqq7fmp8bcf.fsf@gitster.mtv.corp.google.com>
References: <561E5C5B.3090207@alcatel-lucent.com>
	<vpqbnc18ezo.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan Smets <jan.smets@alcatel-lucent.com>, <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:05:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSIw-0003BJ-Uq
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbbJNUFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:05:39 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35565 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbbJNUFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:05:38 -0400
Received: by padcn9 with SMTP id cn9so32146693pad.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6Gjc3Ml8cRi6YrW8FxCMpNgX6az1O+aBsaCzRpl2s1o=;
        b=pE4JXI3Kcv3p6vG91rvb3osVIpo/CesR/le8MeG3efH5Pn38ugUKZGPuJLVm/fsDwN
         p2hjR5wMGGqkL5rjNZ1DXBeEbZ4Vr92hYUY3ri/9kvkXQ8XjOaYgGC3bdLh5qn5V2v8+
         U+327sn4f+i2VlfSAnBh62wkgjhsEMXxARoMh0ZKicClIcVEm0qTegfaGAp80e81PS3Q
         uw6+c9KssmTyj9AkJHH/7aEwq7FvA3XbpfudyNT1leR3w/lWpP0bVZUVqOcD35iVBhVr
         3uqkvDW9J9i7UU6ElOza35Ph8EK9SOlDOYubFbIdJAygnnahqpB7oVQcHmbOXZmtpPDS
         5nEA==
X-Received: by 10.68.219.133 with SMTP id po5mr5435383pbc.135.1444853137850;
        Wed, 14 Oct 2015 13:05:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id eg5sm11238080pac.30.2015.10.14.13.05.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:05:37 -0700 (PDT)
In-Reply-To: <vpqbnc18ezo.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 14 Oct 2015 20:46:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279587>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> This looks like a race between deleting objects/05/ and creating
> objects/05/cdb51bb0ea3e229734a4b1bddd5ec70fbc65ed.
>
> I don't understand how this is possible, since the temporary file and
> the final one are in the same directory, so deleting the directory
> should fail.
>
> What am I missing?

 1. tmp_obj_* gets created in objects/05/ by "git unpack-objects";

 2. prune_cruft() comes, notices tmp_obj_* that is sufficiently old,
    decides to remove in "git prune".

 3. prune_subdir() comes, notices objects/05/ is now empty, does
    rmdir().

 4. "git unpack-objects" closes the file whose inode was originally
    associated with the path objects/05/tmp_obj_*;

 5. "git unpack-objects" calls finalize_object_file() and tries to
    link(2) or rename(2) it to its final name.  It does not find the
    source of the link or rename and says "oops, no such file".
