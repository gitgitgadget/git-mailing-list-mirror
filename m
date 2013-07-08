From: Shawn Pearce <spearce@spearce.org>
Subject: expanding pack idx fanout table
Date: Mon, 8 Jul 2013 08:54:24 -0700
Message-ID: <CAJo=hJsto1ik=GTC8c3+2_jBuUqcAPL0UWp-1uoYYMpgbLB+qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:54:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwDm5-0003Y6-UP
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab3GHPyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 11:54:46 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:64843 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab3GHPyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 11:54:45 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so9927052ieb.24
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=smJt6vQ7Fl+RNOg5dnQQ84UQkTe8ZwSSNp9qwsqy7I4=;
        b=TUPWKjACjUbAiWWN6crw8p7aPnPxJ2jf1WoFCOmoAVhHl4VbZuXbSvRz/GhBmag/aJ
         rJvHbEHgC0hWSHwVJMO63Rb/yhYIjjlgwPSCLXKsevv7H+5s53ZX28KrLekfJHnfAKEZ
         sX2279RiAP8EFl/zhrkN52TjgmfFkdyRP0SsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :x-gm-message-state;
        bh=smJt6vQ7Fl+RNOg5dnQQ84UQkTe8ZwSSNp9qwsqy7I4=;
        b=n5Q439opo3+z77D3DZsS/yw7/AoHFK8XdwujxuWsscao7h9Xr+I60+EhOAyOQzaIQP
         Q9Kvgy7nfkwAnT4o+52hL9WKR7pEZa2Oyrk+99prjkc+KVD53ReD+YXBZaX8VsYL2x+U
         SRfAIVsGQYoyHfvGkuJCyXQG5GKqErlSTL3sdAd7nM3e8oFJzMtq6tGzjtCixPgQ6gkN
         gTOZaZn/JIojZVKr1nk5Ta5Xqb9O0RsjuiaRr/rNTL7Jp+d9CmlV/1nj9ZZUt5GaVk4C
         YjkmSL1rfwxYFbesEG/8p4EtA8L/XfKgG+FsX0fWAHqWiIEnxePJLGB9k2wJzDAPIXoO
         1wRg==
X-Received: by 10.50.114.229 with SMTP id jj5mr8831853igb.36.1373298884938;
 Mon, 08 Jul 2013 08:54:44 -0700 (PDT)
Received: by 10.64.143.200 with HTTP; Mon, 8 Jul 2013 08:54:24 -0700 (PDT)
X-Gm-Message-State: ALoCoQnYW7XYTPMFPh6m+9LmroMY/qRPO1DbRB9SNRSOQ8Kh4aHZmIRN6h9xpst0bvg8zrvhw01d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229870>

Has anyone studied the impact of converting the pack idx fanout table
from 256 entries to 65536 entries?

Back of the envelope estimates for 3.1M objects in linux.git suggests
a 2^16 fanout table would decrease the number of binary search
iterations from ~14 to ~6. The increased table costs an extra 255 KiB
of disk. On a 70M idx file this is noise.

I'm starting to wonder if increasing the fanout table once the object
count is above a certain threshold is a reasonable optimization for
larger repositories.
