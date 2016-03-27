From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v10 2/3] t7507-commit-verbose: store output of grep in a file
Date: Sun, 27 Mar 2016 15:27:25 +0200
Message-ID: <1459085245-20658-1-git-send-email-szeder@ira.uka.de>
References: <CAPig+cRQ5hOLi3539Emq=YexHRXqdesf+Yo2cY+NkiPO_9Vhyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 15:27:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akAjV-0007b0-Dw
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 15:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbcC0N1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 09:27:52 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44615 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751597AbcC0N1v (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2016 09:27:51 -0400
Received: from x590d8713.dyn.telefonica.de ([89.13.135.19] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1akAjK-0001ba-PR; Sun, 27 Mar 2016 15:27:48 +0200
X-Mailer: git-send-email 2.8.0.rc3.58.gc805582
In-Reply-To: <CAPig+cRQ5hOLi3539Emq=YexHRXqdesf+Yo2cY+NkiPO_9Vhyg@mail.gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1459085268.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290006>

> > +! test -s out ||
> > +rm out &&
> 
> Why not just "rm -f out"? But, more importantly, why do you need to
> remove the file at all? The '>' redirection operator (used below) will
> overwrite the file, so no need to remove it beforehand.
> 
> > +! grep '^diff --git' "$1" ||
> > +grep '^diff --git' "$1" >out
> 
> Um, what? Why two greps? I would have expected you to simply re-use
> the existing grep (minus the backslash) while adding the redirection:
> 
>     -exec grep '^diff --git' "\$1"
>     +exec grep '^diff --git' "$1" >out
> 
> Am I missing something obvious?

In the non-verbose cases no diff is included in the commit message
template, thus the pattern looking for it doesn't match anything, grep
exits with error code, which in turn becomes the editor's exit
code, ultimately making 'git commit' fail.  Not good.

I suppose both the explicit 'rm out' and the '! grep ... || ...' is
there to deal with this situation.

Hmph.

I think we could:

  - either revive the idea of two editor scripts: one for the
    non-verbose case checking with '! grep ...' that there are no
    diffs in the commit message template, and one for all verbose
    cases storing those diff lines in a file to be counted later.

  - or use a fake editor that merely copies the whole commit message
    template to a separate file, and we do the greping in the tests
    themselves as well.

  - or simply stick a 'true' at the end of the editor script ensuring
    that it returns success even when grep can't find the pattern, but
    I kind of feel ashamed of myself for even mentioning this
    possibility ;)

I would go for the second possibility, but don't feel strong about it.
