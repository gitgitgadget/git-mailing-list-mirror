From: Stefan Beller <sbeller@google.com>
Subject: Segfault in the attr stack
Date: Wed, 1 Jun 2016 15:00:41 -0700
Message-ID: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:00:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8EBz-0007Eo-3A
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 00:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbcFAWAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 18:00:45 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35227 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbcFAWAn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 18:00:43 -0400
Received: by mail-qg0-f41.google.com with SMTP id e93so114946125qgf.2
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=nGA/IgPHXyLg72eLE3IJWC4QDnt0/9PHjsFmYaivMBg=;
        b=ppLxUCYDXjev2HEjpiVAqSZgUPd6F1l6S+bT9kYxoOVRl3jyxw1B3Xw1AaiqQla5ED
         JjB9s78/t9r9RSdjrzYGeXcRY6JRDMDRLvVdocrVeXcV7X2Jm1J13/+s4p5XVil0Nj2y
         WSqueu6ey5MAcDUq/AACwxOjOx7pNPf/Tj5IatwEGuiK8pRV/jeqRPsw7xMWLKW+rfh5
         PMT03KgvKdB7dIZ4uyiZhyA/x6u4YSHeuiO1eZyoSXx1dwvxwpGCPi5dGSsHSEfnQCwg
         O3BHmHWFBJC/3UrKlux6OUPV+h89DJ+aVT3XZXY8L20EX2G4zAfQD2BRpX0bCFMI8jMq
         fJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nGA/IgPHXyLg72eLE3IJWC4QDnt0/9PHjsFmYaivMBg=;
        b=SzqFZOkzIao+DYTiR5eM7dlmcBIaeWYA2RrgSFcalZnDLuvzXSOxZv/7osUMUaXuAY
         Gg6QYYgxKzdoju/EORbhwIRt7VeTk9t16VNkXRnmtNYXXD9HAATmTis57j++uolqcdgv
         0mqV7iOeEN8NGSXrctH/u5y5EKL3Ts8IXPAlQHVPGvNGfpKXM7dPccCe5ik6Njv4Ay8B
         RAOICwxX28jtz4sZApV3eMHoFqWmZ9pSag/SIHGIlBa2s6Ic8PJhfKeKXPOg1Db5DVNS
         WqQyYOBa3HTFk+/YhfX6WvQC/qAFB1FIVx9gaY3x+xecd0g+CMQvGdp5EP7PY7Mqkzzj
         LJmA==
X-Gm-Message-State: ALyK8tIMIovEdROHlp/m6Nwy/fGwx129BkUd1LpOXbPqyP+iF+1gU8jKPP62x1/kmG1SZoQmgD/x3KIZwePjr+py
X-Received: by 10.140.81.145 with SMTP id f17mr12131140qgd.84.1464818442067;
 Wed, 01 Jun 2016 15:00:42 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Wed, 1 Jun 2016 15:00:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296169>

(running git-next)

In the Gerrit repo I did
    $ echo "/plugins/commit-message-length-validator sub-default"
>>.gitattributes
    $ git status ":(attr:sub-default)"
Segmentation fault (core dumped)

Running this multiple times through gdb, this produces different back
traces as it seems that threads are involved? (So I don't attach a
back trace here)

Also notable are:
*** Error in `/usr/local/google/home/sbeller/bin/git': double free or
corruption (fasttop): 0x00007fffd80008f0 ***
*** Error in `/usr/local/google/home/sbeller/bin/git': double free or
corruption (fasttop): 0x00007ffff0001000 ***

When running another command `git status ":(attr:asdf)"`, I get
git: attr.c:634: prepare_attr_stack: Assertion `attr_stack->origin' failed.
git: attr.c:634: prepare_attr_stack: Assertion `attr_stack->origin' failed.
git: attr.c:634: prepare_attr_stack: Assertion `attr_stack->origin' failed.
git: attr.c:634: prepare_attr_stack: Assertion `attr_stack->origin' failed.
Aborted (core dumped)

The failing assertions are an indication that sb/pathspec-label is
using the attrs incorrectly or
jc/attr added tighter assertions than I was aware of.

Stefan
