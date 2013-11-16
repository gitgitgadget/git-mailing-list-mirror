From: Bryan Turner <bturner@atlassian.com>
Subject: Symbolic refs break ref advertisement on 1.8.4.3+
Date: Sun, 17 Nov 2013 01:39:52 +1100
Message-ID: <CAGyf7-EX2QXKyAwoxv2Ux5cjSp71m-dR+Vq4C3pevJrYaGu42g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 16 15:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhh3A-0001RC-ET
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 15:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057Ab3KPOjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 09:39:55 -0500
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:54728 "HELO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751837Ab3KPOjx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Nov 2013 09:39:53 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]) (using TLSv1) by na3sys009aob134.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUoeDuMVpa5/ZZw106CuctWylBidNFjzg@postini.com; Sat, 16 Nov 2013 06:39:53 PST
Received: by mail-oa0-f48.google.com with SMTP id n16so5183126oag.7
        for <git@vger.kernel.org>; Sat, 16 Nov 2013 06:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=dXa60EXOeDEMLUsnx5H1Pg1gZ3slLKCMp/MbIszBzRQ=;
        b=dw2wGgKtd73SRWdNfwIboKNGMoM7yDtjJcLpV2hSHZHvjPKMguqk62tfh5hfe1bktK
         hCGR+E7p4FQ8QhCx+SoG67b0cXPVukGSoyWEzCSIsT5CpYWa8UO9bD1jSTLK9cP9wK9J
         xxg2yTTlgNzboRnltN5Y8SkleRoocfeqo+s1lm9N2K+plEW90auDc4ZtQw2+lfUf3CD+
         /jwsfze0W5XwFrOjkdSWyczpIa6isUtGg6JiSpMAJ2Pm+Nbi5W9VPsGE5jyrmvpKXm+D
         StsvNJx3z3NjSVR/O3zxvlZZhg+1g7JxOyaYsRg44tt0jEb+/ylBE27M7/P1WSkOUsDq
         sJOg==
X-Gm-Message-State: ALoCoQmvtKHQgE0NnLyBXIgeoYrK8tlBQCfU0AapUoaUfaFRoqjxb+XwrN3QGR+c2UH8+CJFALVxVcXzY1HKhk7dcSVMWUpfrlufXrehNjzEiIIyd9qtoL6g6vf4fhUpSjV9FhziLelgQA+q7j+WFblfuYyBEl9ROw==
X-Received: by 10.60.133.233 with SMTP id pf9mr12027096oeb.46.1384612792298;
        Sat, 16 Nov 2013 06:39:52 -0800 (PST)
X-Received: by 10.60.133.233 with SMTP id pf9mr12027088oeb.46.1384612792152;
 Sat, 16 Nov 2013 06:39:52 -0800 (PST)
Received: by 10.182.92.114 with HTTP; Sat, 16 Nov 2013 06:39:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237929>

According to a git bisect between the v1.8.4 and v1.8.4.3 tags, it
appears the changes in 5e7dcad, "upload-pack: send non-HEAD symbolic
refs", cause the ref advertisement to fail of the repository has more
than a handful of symbolic refs. Here's a simple reproduce case
(tested on Bash):

Aphrael:example bturner$ git version
git version 1.8.4.3
Aphrael:symbolic-refs bturner$ git init example
Initialized empty Git repository in /Users/bturner/example/.git/
Aphrael:symbolic-refs bturner$ cd example
Aphrael:example bturner$ echo "Testing..." > file.txt
Aphrael:example bturner$ git add file.txt
Aphrael:example bturner$ git commit -m "Initial commit"
[master (root-commit) b4c4b2a] Initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 file.txt
Aphrael:example bturner$ for ((i=1;i<21;i++)); do git symbolic-ref
refs/heads/syms/$i refs/heads/master; done
Aphrael:example bturner$ git ls-remote .
fatal: protocol error: impossibly long line
fatal: Could not read from remote repository.

A symref= entry is written into the first packet of the ref
advertisement, right after the capabilities, for each symbolic ref in
the repository. Unfortunately, no splitting is done on that value and
so once you have 15-20 symbolic refs (more or less depending on path
lengths), you blow the 996 byte limit in format_packet (pkt-line.c)
and all further clone/fetch operations fail.

I've verified this same issue exists in all 1.8.5 RCs.

Best regards,
Bryan Turner
