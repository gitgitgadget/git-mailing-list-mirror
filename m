From: Jed Brown <jed@59A2.org>
Subject: Re: [RFC/PATH 3/4] remote-hg: add version checks to the marks
Date: Fri, 05 Apr 2013 07:46:20 -0500
Message-ID: <8738v5qh5v.fsf@59A2.org>
References: <1365161779-32170-1-git-send-email-felipe.contreras@gmail.com> <1365161779-32170-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 18:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWH6-0002u6-UI
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243Ab3DEMqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 08:46:25 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:39387 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765141Ab3DEMqY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 08:46:24 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so4246617iec.32
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 05:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=SjkAQLCCFBOhwpg+ZqZcX+ri8AtRBtU/QcwLeImLjHA=;
        b=JIMwGB5mkEs5nsGJaCbU9MVV0PVR0T1hqKEpgSxYof3B+4iRb+pTZRYi+4DEMsKqZL
         h0YkXnkk9hvZ7sbpqMm/EYO6siBvzGBnBJX2WYQDvaZ8xnhPZRT4oF25VewoowFHb8BP
         x+gxVulukN9EspbTX1xU62qkACV8gA7msef7a3Dlm5AWvSdZZd86nznRePfC6KfypsFv
         Xd6YtBT510Yp0Gwrjx8VHbhTgdWmz/5nY+vJkmWgTfm6h+qob8e7vW8yb9c3qZYnZ+Si
         HHfkA9RYJX/2log9j4ashz8i2I1Esun2zOn201eCirZL28CyM/80le9PuVn9Ni4hZqsh
         ZhBA==
X-Received: by 10.50.222.167 with SMTP id qn7mr1517920igc.42.1365165983772;
        Fri, 05 Apr 2013 05:46:23 -0700 (PDT)
Received: from localhost ([38.69.41.96])
        by mx.google.com with ESMTPS id ua6sm2184282igb.0.2013.04.05.05.46.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 05:46:23 -0700 (PDT)
In-Reply-To: <1365161779-32170-4-git-send-email-felipe.contreras@gmail.com>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220174>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> @@ -76,12 +78,19 @@ class Marks:
>  
>      def __init__(self, path):
>          self.path = path
> +        self.clear()
> +        self.load()
> +
> +        if self.version < VERSION:
> +            self.clear()

It's friendlier to just upgrade the marks in-place. This takes less than
one second to run on repositories where full re-import would take half
an hour:

    def upgrade_marks(self, hgrepo):
        if self.marks_version == 1: # Convert from integer reversions to hgsha1
            warn("Upgrading marks-hg from hg sequence number to SHA1")
            self.marks_to_revisions = dict(
                (mark, hghex(hgrepo.changelog.node(int(rev))))
                for mark, rev in self.marks_to_revisions.iteritems())
            self.revisions_to_marks = dict(
                (hghex(hgrepo.changelog.node(int(rev))), mark)
                for rev, mark in self.revisions_to_marks.iteritems())
            self.marks_version = 2
            warn("Upgrade complete")

https://github.com/buchuki/gitifyhg/commit/23a6709efd14f3e058e3a846624b7677d1e8b497#L0R195
