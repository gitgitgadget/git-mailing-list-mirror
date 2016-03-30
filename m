From: shawn wilson <ag4ve.us@gmail.com>
Subject: git alias quoting help
Date: Wed, 30 Mar 2016 00:13:30 -0400
Message-ID: <CAH_OBievBBjzLwPZf3-qLn-SQyJG0UHhbdkvyZFfC8b-TsTUJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 30 06:13:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al7Vz-0007zG-PF
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 06:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbcC3ENv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 00:13:51 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33215 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcC3ENu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 00:13:50 -0400
Received: by mail-pf0-f175.google.com with SMTP id 4so31542128pfd.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 21:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=kLG/rmpJk4Ea6DNFnGjBONGagF9AmaLgizClAHPWW/8=;
        b=n+fhJWkyDcj4Dp+yBnpFVjkIsAsMPutxyV53OR2iVTLk+NOXglnKDR/bY5zocaK5gp
         fhOXnnMjSY43kQjcYPi2AI1b/YS+bM52pi97suHGvrlbDdq9Q7Wdx1pEse9spDVVV4FU
         C4u2/gJ7pdRaGZcu/eRDx3yWzRn9PhQlrTdHVqz1GIokugYRDOqLi5EKP+j774cXpD18
         B7T5q156G0Z0dodp1J8tG0o6DOCAwLBYSHETyQlMps3X5yULyh9D0QMlLdRhijG53+Hc
         nvGppOsZILEAmY5L87M5w+6/dll5HO4qGDPFULAgLa8ygDWI00Vy/3PWoQxu64RIUEFN
         nIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kLG/rmpJk4Ea6DNFnGjBONGagF9AmaLgizClAHPWW/8=;
        b=UGYnk0aDvogMNDAvPmMUiZIAarE5K1elHZZltJIBBWIxApAcgv7Jqyv1T2KhRdW1i2
         XrvqG1C/Q3bd03m+qWNrdEABNkRY6baJbhp8/Fe9//MuZ8zsncksGjqK3GjzUA36BfZe
         Tp35v2X/GTLm7iQbMVA66aInT9Ih8+hsH3e5vRnZp7xJ4SSIT8T3vYk4VJDJgJn4QqPQ
         YGi3nhuHfXg+SVWzyQsWT7FfZS20rvKTDCSgPP1voN/IcGBHEWFp6ESqKISYZj2f5Jhk
         obSauV3KDUJdDfEEH15Vn28CKZ3tPVkaDCO/SQ8LLWagmAQ/gy//LESfVM1CO/TFk0vU
         CDsQ==
X-Gm-Message-State: AD7BkJLg6Q81KjLJsKs+t6ylxoWqda0xuXSzixQRij0vmToSzHa4hEiuCV59i6XRI/n0iJp+EuSBylOvLi475Q==
X-Received: by 10.98.67.76 with SMTP id q73mr9402487pfa.137.1459311229867;
 Tue, 29 Mar 2016 21:13:49 -0700 (PDT)
Received: by 10.66.5.163 with HTTP; Tue, 29 Mar 2016 21:13:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290266>

I've also tried to make this a plain bash script (w/o the function or
if statements and am failing at the same place). The issue seems to be
with the quoting in the filter-branch | ls-files bit. Also, the end
goal here is to be able to move a directory from one repo and keep the
history. While this works if I do it at the command line, it's just
too many steps (is tedious). Also, if there's a way to do the same
thing with multiple directories in one shot, (or make this work with
something like: cookbooks/{a,b,c} # as a parameter) that'd be perfect.

  reapdir = "!f() { \
    if [ -d "$1" ] ; then \
      git filter-branch --prune-empty --subdirectory-filter "$1" -- --all && \
      git gc --aggressive && \
      git prune && \
      git filter-branch -f --prune-empty --index-filter '\
        git ls-files -s \
          | sed \"s-\\t-&$1-\" \
          | GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index
--index-info && \
            mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE'; \
    else \
      echo "No directory $1"; \
    fi; }; \
  f"
