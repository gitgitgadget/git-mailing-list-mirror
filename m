From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Questions about git-push for huge repositories
Date: Sun, 06 Sep 2015 10:48:00 -0700
Message-ID: <xmqq4mj7bfsf.fsf@gitster.mtv.corp.google.com>
References: <CAN6cQGPcGpaXUGu_7aaeJtMbruMocte-5po97vG5r39f=YdTZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Levin Du <zslevin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 19:48:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYe2y-00080z-7Y
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 19:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbbIFRsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 13:48:05 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35651 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbbIFRsC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 13:48:02 -0400
Received: by pacfv12 with SMTP id fv12so74500587pac.2
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OPCyyIpuMSOfU1thcUNcNBQ3YDzsgbhChpIlKoG/ASE=;
        b=fYPWRZ6ONnVk1k6pUvn5QGUrD6FbjJhfrNQyNp4dutYnd7dx1iPkfuWXa5sR/uiJ5L
         Fhf6KgQPEhINHGYG6OgrErrAH0TkIck7QUCAwoAkyn5be2PH7sIGF/ZKZdtCNJLGfUH6
         SJqA9aB3crSKepYgJRogWHkwkK4LuTyG6wAf5YU/Ugq2ogq3yDSTE3YK9CrV7DEpVUNG
         +TJ8r8vAywESY9XPoQA9hcTOO6p2P/6UEF8mGozPr4qXVyYIg6OJr59H0j4jlYXfXjvk
         M1k+GNmBQbhwk9l5tLc3CaL6lE9gVUWQouaHDcA3gzh2/7dxJKqmICT7zs5Mp7oHgcVL
         Hr0A==
X-Received: by 10.66.62.229 with SMTP id b5mr35184905pas.81.1441561682330;
        Sun, 06 Sep 2015 10:48:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:91db:290:be53:1b89])
        by smtp.gmail.com with ESMTPSA id xv1sm9197964pbb.25.2015.09.06.10.48.01
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sun, 06 Sep 2015 10:48:01 -0700 (PDT)
In-Reply-To: <CAN6cQGPcGpaXUGu_7aaeJtMbruMocte-5po97vG5r39f=YdTZQ@mail.gmail.com>
	(Levin Du's message of "Sun, 6 Sep 2015 16:16:31 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277433>

Levin Du <zslevin@gmail.com> writes:

> Since A & B share many common files, to save disk space, I'd like to merge them:
> (note: branch of A & B are independent, i.e. have no common ancestor.)

Not having any shared history is exactly the cause.  If the
optimization were to exchange list of all the commits, blobs and
trees each side has and sending only the ones that the receiving end
lacks, you would get the result you seem to be expecting, but that
approach is not taken because it is impractically expensive.

Instead, the object transfer is optimized by comparing what commits
each side has and sending trees and blobs that are reachable from
the commits that the receiving side does not have.  This approach
does not have to exchange the list of trees and blobs at all, and in
a pair of repositories for the same project, it does not even have
to send the list of all commits, because traversing from the tips of
histories and exchanging more recent ones iteratively is expected to
find commits common to both and because of the history graph is a
DAG, we know what is behind commits that are common exist on both
ends.
