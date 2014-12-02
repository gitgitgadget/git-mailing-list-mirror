From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/4] refs.c: use transactions for the reflog
Date: Mon,  1 Dec 2014 23:46:38 -0800
Message-ID: <1417506402-24257-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 02 08:46:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XviAe-0006Qg-1G
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 08:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbaLBHqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 02:46:47 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:63904 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbaLBHqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 02:46:46 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so10358908igi.12
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 23:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=r8TskEffZzZDFcZQZase/wc/jcKbvoXC9+17ZODp0+w=;
        b=ZFy9ifBJ6XaGBu5WFz2mFEu8qfEYz4rzTCOzDi1Yi2kGNyMa5S+Vy6LIh0UZosfKCh
         XF6E3JfXdPKpJW0D4caNvBoHET6jjqkGdfMlzGEea1024MaP+mfIECJVHD7OKzNnrROC
         YQAjtzW4Xs3amVQYIVuEZwOmbzAAEWnAuG11cS3PsqmniZuUoFiasnx3DDAP/dxMpxhU
         eit+v2/ry27oeY/RHYXO43HUTgBB6KnX7zUen35THwpMG+FMs5GktTl3APuhlr4zgc/e
         YQKn9r7rHpYCMo87KQ0oXyqAnC16xplv4n3CnOg7doleiFp9zSKbKzYaEVtcU/PtO9lw
         Ax5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r8TskEffZzZDFcZQZase/wc/jcKbvoXC9+17ZODp0+w=;
        b=OLy+6FnvgsxkjBq5HXl2qXxQreTBOxxnyGYJIJkfYCsjsCLUgZ5vv8Zs/Wk+8Tb+Xz
         93GP6q8b3slH+gHwBLmUeWR/JDpvzCXy9K4DSaeUuymGzbWhfwFY3QqxanjOSeefjzrB
         7W4822FmNo3FEJGKIc2OYUBn1Sn3lrm4ghVNTRNdVNh28VAUAo3I9cc3VZ049//ukXKt
         9oGuLqXdM8EsRneW3rxrTmKK0EB1uo+xvlrzHNGk0awUpeATwwa8EYgDpEr2eyNruUOE
         a5wM686c4fdR2JirZLKG+Kze3s3nd/0A7XGBfctlTXJt+jzBXjCuQh9X5bDPV46H9zRP
         quHA==
X-Gm-Message-State: ALoCoQmByRqOjzHyTZ7+EVFeSMtrGqq0XR6R0pkyuqY9zFN1keB/wBL4iduCJRs0Iirz1VxNDcgX
X-Received: by 10.42.22.140 with SMTP id o12mr1502444icb.87.1417506405784;
        Mon, 01 Dec 2014 23:46:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:21e7:446b:f329:a30a])
        by mx.google.com with ESMTPSA id n126sm10796408ion.13.2014.12.01.23.46.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 23:46:45 -0800 (PST)
X-Mailer: git-send-email 2.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260544>

This is the core part of the refs-transactions-reflog series[1],
which was in discussion for a bit already.

The idea is to have the reflog being part of the transactions, which
the refs are already using, so the we're moving towards a database
like API in the long run. This makes git easier to maintain as well
as opening the possibility to replace the backend with a real database.

The first patch is essentially just some sed magic with reformatting
the code, so the naming convention fits better, because the transactions
will handle both the refs as well as the reflog after this series.

The second patch is also just a rename patch.

The meat and most of the lines of code are found in the 3rd patch.
It was completely rewritten from scratch using ideas provided by
Jonathan, thanks! We'll treat the refs and reflogs a bit differently
within the transaction updates data structure, as the hard part for
the refs is during the commit phase, while the hard part for the reflogs
is during the preparation phase now.

We're using a temporary file for creating the new reflog and rename it
into place afterwards utilizing the lock file API.

The last patch makes actually use of the reflog transaction API.

Any comments would be appreciated,
Thanks,
Stefan
