From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 0/5] pathspec magic extension to search for attributes
Date: Wed, 18 May 2016 12:02:17 -0700
Message-ID: <20160518190222.28105-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed May 18 21:02:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b36jp-00023o-Mr
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 21:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbcERTC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 15:02:28 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32829 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbcERTC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 15:02:27 -0400
Received: by mail-pf0-f170.google.com with SMTP id 206so21471307pfu.0
        for <git@vger.kernel.org>; Wed, 18 May 2016 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2uS3DQqzgXHGzA1AwKh6r3RKixGK5KQFknr/FTguLZs=;
        b=TvFGg97Cy4vKsXq2kU/KGemTdu1o7iHa93tnRJPNMwqciyCfe3bS9C7aIcvRoDsqlR
         hRAA5HStQD8mRVGKk1JBnmvaLSs6JVjByJEgov3/yNFcT6e3LVTqvfU//XEWMvb8SQoa
         ZDgi8PASGdpwDMlEs9228oX6PZK8j3woIBD0iuM7LoS/xW8hUQn6lc7k9t5RVtq1C4NK
         2kowKp9qw86TN0X3MeX1OnT++S2tPZb6QCvRCSnrWoSbfETWLtGr9ZtA76PxJqxy5dd3
         iYwibvAq/Z6Mc5b2BAgwREO/IvbCUKNkY2JOKXlV8bIw5Li68U/BMVORxY/qFnTTVbZn
         Nqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2uS3DQqzgXHGzA1AwKh6r3RKixGK5KQFknr/FTguLZs=;
        b=SY2OTwo0cNTWavjnqHM4FvyclyUohoqLnUS27OqGNcApRDLVtP8Tubxdmkaor2nN52
         qDFXE4Z0FXL/+HYdCjUvSnafD6spmDlPPCE/+eXSVG+Ldwz28LIZcPTyOquThWGcu6cO
         my6tL5dikLrMYIPi+WLA2+j5gNhmxGtfMGm2lcTkfu2J/DUt/5O74S6CcgVmg7cstVZd
         bKDGKkgtgiBIEVw50rlJsAm16UN6ZNFllCXcJxOVK7H2A1URT684U1Np8Hmiuy8l4P3d
         Omn3w2dxyuw+SagnNuU+sdK6mPmlmoyorjqUJdEZPWxv6jgMQVwGdnQlftGSmwnXNR6W
         9kGA==
X-Gm-Message-State: AOPr4FWyWaOsp/+eOXy+pK2c/YJZsSrIcOVh079SCbZuMmqHWDL8mOo6Ati0rRpJQmKADG8v
X-Received: by 10.98.92.71 with SMTP id q68mr13348431pfb.138.1463598146128;
        Wed, 18 May 2016 12:02:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d468:afb3:b0f0:947e])
        by smtp.gmail.com with ESMTPSA id nz6sm14029002pab.39.2016.05.18.12.02.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 12:02:25 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.121.ga97fb08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294989>

This goes on top of origin/jc/attr, (8195c5cde01, SQUASH???, 2016-05-17 14:08:50)

Patches 1 and 2 are small fixes, which could go independently as well.
(1 is new compared to v6)

Patches 3 and 4 are refactoring pathspec.c a little.

The last patch is the most exciting patch as it adds the new feature.
Quoting from the documentation update:

        attr;;
                Additionally to matching the pathspec, the path must have the
                attribute as specified. The syntax for specifying the required
                attributes is "`attr: [mode] <attribute name> [=value]`"
        +
        Attributes can have 4 states (Set, Unset, Set to a value, unspecified) and
        you can query each attribute for certain states. The "`[mode]`" is a special
        character to indicate which attribute states are looked for. The following
        modes are available:
        
        - "`+`" the attribute must be set
        - "`-`" the attribute must be unset
        - "`~`" the attribute must be unspecified
        - "`?`" the attribute must not be unspecified, i.e. set, unset or value matches
        - an empty "`[mode]`" matches if the attribute is set or has a value
        - an empty "`[mode]`" combined with "`[=value]`" matches if the attribute has
          the given value.
        +

While I followed Junios suggestion of the data layout in pathspec.h,
I am not quite happy with it yet as I think it will not be easy in the future
to enhance search for specific attribute values. Quoting from the tests:

        test_expect_success 'check label with 2 labels' '
                cat <<EOF >expect &&
        fileAB     # has both labels
        sub/fileAB # has both labels
        EOF
                git ls-files ":(attr:labelA labelB)" >actual &&
                test_cmp expect actual &&
                git ls-files ":(attr:labelA,attr:labelB)" >actual &&
                test_cmp expect actual
        '

You can see that two notations are possible to narrow the search down when
asking for 2 attributes to be set. Either you can do 2 "attr:" magic strings
or you can have one "attr:" and then a space separated list of attributes.

The problem arises once you'd want to have a better search for values, as
currently only ":(attr:label=value) is supported with "value" being the
exact match, e.g. a path having more than just value would not match as it is
not exact. E.g. in git.git we have

        $ cat .gitattributes 
        * whitespace=!indent,trail,space
        *.[ch] whitespace=indent,trail,space
        *.sh whitespace=indent,trail,space
        $ git ls-files ":(attr:whitespace=indent)"
        $ # no match!

So instead of matching exactly we'd want to just look for the value being
one part of the comma separated list as setup in .gitattributes.
However searching for more than one value will be complicated, as we'd then
need to escape commas. My vision was to use white spaces instead, but they
are now taken to separate different attributes.

So in the future I would imagine to have escaping like 

        git ls-files ":(attr:label=value\,value2 labelA=value3,exclude)
        
or yet another separator like

        git ls-files ":(attr:label=value1;value2 labelA=value3,exclude)

Thanks,
Stefan

        
Stefan Beller (5):
  string list: improve comment
  Documentation: fix a typo
  pathspec: move long magic parsing out of prefix_pathspec
  pathspec: move prefix check out of the inner loop
  pathspec: allow querying for attributes

 Documentation/gitattributes.txt    |   2 +-
 Documentation/glossary-content.txt |  19 ++++
 attr.c                             |   2 +-
 attr.h                             |   2 +
 dir.c                              |  46 ++++++++++
 pathspec.c                         | 182 +++++++++++++++++++++++++++++--------
 pathspec.h                         |  16 ++++
 string-list.h                      |   2 +-
 t/t6134-pathspec-with-labels.sh    | 177 ++++++++++++++++++++++++++++++++++++
 9 files changed, 407 insertions(+), 41 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

-- 
2.8.2.121.ga97fb08
