From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Notes on Using Git with Subprojects
Date: Tue, 26 Sep 2006 10:40:56 -0700
Message-ID: <45196628.9010107@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 26 19:42:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSGw1-0006ET-AH
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 19:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWIZRlH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 13:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWIZRlG
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 13:41:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:46719 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932185AbWIZRlD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 13:41:03 -0400
Received: by nf-out-0910.google.com with SMTP id o25so260128nfa
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 10:41:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=k04I26hAgdtfuBRZAlUHBbaYcUJiJy0JmY0vOFdaEvo3I8TC+ylf1IuncMKmYcg0aEczIkKCsDFq2p1YN2FYV3Cy0HMTtyF02ODDjm6pMjwhkiDjRxLczM1mAfuLIssILarU71iOErnLUSplQQMQyM8t7QZPrxaQqAyUMArPU2M=
Received: by 10.78.148.8 with SMTP id v8mr474185hud;
        Tue, 26 Sep 2006 10:41:01 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id 2sm2877022hue.2006.09.26.10.40.59;
        Tue, 26 Sep 2006 10:41:00 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27803>

							20060926.1715

Notes on Using Git with Subprojects
===================================
Copyright (C) 2006 by Raymond S Brand


Git does not have native support for subprojects and this is a good
thing because managing subprojects is better handled by the project
build machinery. Managing subprojects with the project build machinery
is more flexible than the native support from an SCM and allows the use
of different SCMs by different subprojects. However, there is a lot of
interest in using Git for the SCM of a project with subprojects.

Git, unfortunately, does not make it easy. What is wanted is to put all
of the subprojects in one repository and be able to checkout the various
parts from a local copy of the repository. The problem is, with Git, a
repository can have at most one working directory associated with it at
a time. This is because Git stores a lot of information about the
contents of the working directory in the repository. In fact, the usual
situation is that the repository, itself, is in the working directory.

This note describes a method to use Git with subprojects; other methods
are also possible.


Definitions
-----------
Parent Project:
	A project that logically contains one or more subprojects.

Project:
	A set of files that is (relatively) self contained with respect
	to changes and treated as a unit by the SCM.

Root Project:
	A project that is not a subproject.

Subproject:
	A project logically contained in another project.


Setup
-----
All subprojects are contained in a single repository and referred to by
separate branches in $GIT_DIR/refs/heads/. Developers create a local
copy of the project repository; hereafter, referred to as the "local
master repository" or just "local master". All fetches, pulls and pushes
by the developers with the "local master" of other developers should be
to and from their own "local master".


Root Project Checkout
---------------------
The root project is the project that all of the subprojects are a part
of. It is a parent project of one or more subprojects; each of which can
also be parent projects to other subprojects.

To checkout the root project, choose an name for the project working
directory (the working directory must not already exist) and perform the
equivalent of the following commands.

	git-clone -s -n $LOCAL_MASTER $ROOT_DIR \
		&& cd $ROOT_DIR \
		&& git-checkout -b $ROOT_BRANCH--local $ROOT_BRANCH

Where:
	$LOCAL_MASTER is the path to the "local master"
	$ROOT_DIR is the name of the working directory to use
	$ROOT_BRANCH is the branch name of the root project
	$ROOT_BRANCH--local is a branch for local changes

This will leave the current working directory of the shell in the
project working directory.

This also creates a branch with the suffix of "--local" to hold all of
the local working directory commits and modifications. The $ROOT_BRANCH
is used as a tracking branch so that upstream changes can be fetched
into the working repository without affecting the checked out files.

Once the root project is checked out, the subprojects are checked out.


Subproject Checkout
-------------------
Each project that is a parent project needs to checkout all of the
subprojects of the project. Each subproject is checked out with the
equivalent of the following bash commands:

	git-clone -s -n $LOCAL_MASTER $SUBPROJECT_DIR \
		&& ( cd $SUBPROJECT_DIR \
			&& git-checkout -b $SUBPROJECT_BRANCH--local \
				$SUBPROJECT_BRANCH
		)

Where:
	$LOCAL_MASTER is the path to the "local master"
	$SUBPROJECT_DIR is the directory name of the subproject
	$SUBPROJECT_BRANCH is the branch name of the subproject
	$SUBPROJECT_BRANCH--local is a branch for local changes
	
If a subproject has subprojects, then the checkouts need to done
recursively. With suitable project/subproject/branch naming conventions
this can easily automated.


Project Development
-------------------
Changes to a project are performed in the working directory of the
project and are recorded in the repository in the working directory on
the $PROJECT--local branch.


Receiving Project Upstream Changes
----------------------------------
Upstream project changes are first fetched into the project tracking
branch of the local master repository and are then fetched into the
project tracking branch of the working directory repositories. To merge
upstream changes into the working directory, a pull from the project
tracking branch of the working directory repository executed.

	# Fetch project branch from upstream to local master
	(cd $LOCAL_MASTER && git-fetch $UPSTREAM $PROJECT_BRANCH)

	# Fetch project branch from local master to working repo
	git-fetch $LOCAL_MASTER $PROJECT_BRANCH

	# Merge upstream changes in to working directory
	git-pull --no-commit . $PROJECT_BRANCH

Where:
	$LOCAL_MASTER is the path to the "local master"
	$UPSTREAM is the Git URL of the upstream repository
	$PROJECT_BRANCH is the branch name of the (sub)project
	

Sending Project Changes Upstream
--------------------------------
To send project changes upstream from a working directory repository,
the changes are first pushed to a branch in the local master repository,
$PROJECT--$IDENT. The changes can then be pushed or pulled from the
local master repository.

	# Push project changes to local master
	git-push $LOCAL_MASTER \
		$PROJECT_BRANCH--local:$PROJECT_BRANCH--$IDENT

	# Push project changes from local master to upstream
	(cd $LOCAL_MASTER && git-push $UPSTREAM \
		$PROJECT_BRANCH--$IDENT:$PROJECT_BRANCH--$NICK--$IDENT)

Where:
	$LOCAL_MASTER is the path to the "local master"
	$UPSTREAM is the Git URL of the upstream repository
	$PROJECT_BRANCH is the branch name of the (sub)project
	$PROJECT_BRANCH--local is a branch for local changes
	$IDENT is a label unique for this set of working directories
	$NICK is a (branch name safe) identifier of the developer
	

Automation
----------
Adding the following example code to the makefiles of the root project
and subprojects with the appropriate information can automate most of
the operations needed to support subprojects with Git. The ProjectSetup
target needs the REPOSITORY and IDENT make variables to be set but the
other targets will use the values saved by the ProjectSetup target.

 ---->8----  ---->8----  ---->8----  ---->8----  ---->8----  ---->8----
# Add this to the makefiles
PROJECT := branch/name          # Relative to $GIT_DIR/refs/heads/
SUBPROJECTS := a/b c/d          # Each relative to $GIT_DIR/refs/heads/
include Git_machinery.make

# Rest of the Makefile
 ---->8----  ---->8----  ---->8----  ---->8----  ---->8----  ---->8----
# Git_machinery.make

include GIT-SUBPROJECT-VARS.make

REFS := /refs/heads/$(REFPREFIX)

GIT-SUBPROJECT-VARS.make:
	rm -rf GIT-SUBPROJECT-VARS.make
	echo "REPOSITORY := $(REPOSITORY)" > GIT-SUBPROJECT-VARS.make
	echo "REFPREFIX := $(REFPREFIX)" >> GIT-SUBPROJECT-VARS.make
	echo "IDENT := $(IDENT)" >> GIT-SUBPROJECT-VARS.make

ProjectSetup:: GIT-SUBPROJECT-VARS.make
	for SUBPROJECT in $(SUBPROJECTS) ; \
	do \
	    git-clone -s -n $(REPOSITORY) $$(basename $$SUBPROJECT) \
	    && ( cd $$(basename $$SUBPROJECT) \
		&& git-checkout -b \
		    $(REFS)$$SUBPROJECT--local $(REFS)$$SUBPROJECT \
		&& $(MAKE) ProjectSetup \
	    ) \
	done

FetchMaster::
	git-fetch $(REPOSITORY) $(REFS)$(PROJECT)
	for SUBPROJECT in $(SUBPROJECTS) ; \
	do \
	    $(MAKE) -C $$(basename $$SUBPROJECT) FetchMaster ; \
	done

PullMaster::
	git-fetch $(REPOSITORY) $(REFS)$(PROJECT)
	git-pull --no-commit .  $(REFS)$(PROJECT)
	for SUBPROJECT in $(SUBPROJECTS) ; \
	do \
	    $(MAKE) -C $$(basename $$SUBPROJECT) PullMaster ; \
	done

PushMaster::
	git-push $(REPOSITORY) \
	    $(REFS)$(PROJECT)--local:$(REFS)$(PROJECT)--$(IDENT)
	for SUBPROJECT in $(SUBPROJECTS) ; \
	do \
	    $(MAKE) -C $$(basename $$SUBPROJECT) PushMaster ; \
	done

 ---->8----  ---->8----  ---->8----  ---->8----  ---->8----  ---->8----

The example Makefile code has some limitations: There is no error
checking. It does not handle subprojects rooted in a non top level
directory of the parent project. There are other Git commands that can
be usefully applied recursively to all subprojects.
