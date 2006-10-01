From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on Using Git with Subprojects
Date: Sat, 30 Sep 2006 22:19:06 -0700
Message-ID: <451F4FCA.7060804@gmail.com>
References: <45196628.9010107@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 01 07:19:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTtjo-0000AA-2g
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 07:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWJAFTL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 01:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWJAFTL
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 01:19:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:6264 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750712AbWJAFTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 01:19:09 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1370287wxc
        for <git@vger.kernel.org>; Sat, 30 Sep 2006 22:19:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GqE4X0/61df7XwoHJy5vtH7yJrV1QuSS39IkYuY5RLHSpcbMllUsKVoNRmZGz1TyoGXMcgFGtkwvu8/Aoc4oI6pz5L6MPe7Aivzw8SEHamp1uSlzeLeCxeFz9mHAFxTzvwZekGqKTM2f7sVLZ9BPuxpb9iRlWCvXUR6sw/cic8o=
Received: by 10.70.87.9 with SMTP id k9mr4001403wxb;
        Sat, 30 Sep 2006 22:19:08 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.gmail.com with ESMTP id i14sm7071786wxd.2006.09.30.22.19.07;
        Sat, 30 Sep 2006 22:19:08 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: git@vger.kernel.org
In-Reply-To: <45196628.9010107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28170>

This updates the note based on the discussion the original note 
generated. The most significant difference is the ability to specify 
a particular version of a subproject.


							20061001.0400

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

An important criteria for supporting subprojects is that a subproject
may be developed and controlled by an entity or organization different
than that of the parent project of the subproject. As a consequence of
this, the build machinery needed to manage a project controlled by
another entity as a subproject must be in the parent project. 

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

Super project:
	A project composed of subprojects.


Setup
-----
All subprojects are contained in a single repository and referred to by
separate heads or tags. Developers create a local copy of the project
repository; hereafter, referred to as the "local master repository" or
just "local master". All fetches, pulls and pushes by the developers
with the "local master" of other developers should be to and from their
own "local master".


Root Project Checkout
---------------------
The root project is the project that all of the subprojects are a part
of. It is a parent project of one or more subprojects; each of which may
also be parent projects to other subprojects.

To checkout the root project, choose an name for the project working
directory (the working directory must not already exist) and perform the
equivalent of the following commands.

	git-clone -s -n $LOCAL_MASTER $ROOT_DIR \
		&& cd $ROOT_DIR \
		&& git-checkout -b $ROOT_BRANCH--local $ROOT_VERSION

Where:
	$LOCAL_MASTER is the path to the "local master"
	$ROOT_DIR is the name of the working directory to use
	$ROOT_VERSION is the ref name of the root project state
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
				$SUBPROJECT_VERSION
		)

Where:
	$LOCAL_MASTER is the path to the "local master"
	$SUBPROJECT_DIR is the directory name of the subproject
	$SUBPROJECT_VERSION is the ref name of the subproject state
	$SUBPROJECT_BRANCH--local is a branch for local changes
	

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
	$PROJECT_BRANCH is the tracking branch of the (sub)project
	$PROJECT_BRANCH--local is a branch for local changes
	$IDENT is a label unique for this set of working directories
	$NICK is a (branch name safe) identifier of the developer


Automation
----------
The following proof of concept code can be added to parent project
makefiles to automate most of the operations needed to support
subprojects with Git.

 ---->8----  ---->8----  ---->8----  ---->8----  ---->8----  ---->8----
# Add this to the makefiles

SUBPROJECTLIST := GIT:s1_ref:s1_dev:s1 \ 
		  GIT:s2_ref:s2_dev:s2 \ 
		  GIT:s3_ref:s3_dev:s3

include Git_machinery.make

# Rest of the Makefile
 ---->8----  ---->8----  ---->8----  ---->8----  ---->8----  ---->8----
# Git_machinery.make

GIT-CLONE := gitclone
GIT-CHECKOUT := gitcheckout
GIT_FETCH := gitfetch
GIT-PULL := gitpull
GIT-PUSH := gitpush

include GIT-SUBPROJECT-VARS.mak

GIT-SUBPROJECT-VARS.mak: Makefile
	@rm -rf GIT-SUBPROJECT-VARS.mak
	@echo "REPOSITORY := $(REPOSITORY)" > GIT-SUBPROJECT-VARS.mak
	@echo "IDENT := $(IDENT)" >> GIT-SUBPROJECT-VARS.mak

# SUBPROJECTLIST has the following format:
#	Each "word" in the list starts with a scheme identifier followed
#	by a ':'. The reainder if the "word" is the scheme specific
#	subproject details.
#   Scheme: GIT
#	The scheme specific subproject details are 3 fields separated by
#	':'s.
#	Field 1: Version reference - reference to checkout and fetch
#		from.
#	Field 2: Development branch ref name.
#	Field 3: Sub directory for the subproject.

GIT--subproject--setup::
	for SUBPROJECT in $(filter GIT:%,$(SUBPROJECTLIST)) ; do \
	  PARAM=($$(echo $$SUBPROJECT | tr ':' ' ')) ; \
	  $(GIT-CLONE) -s -n $(REPOSITORY) $${PARAM[3]} \
	  && ( cd $${PARAM[3]} \
	    && $(GIT-CHECKOUT) -b $${PARAM[2]}--local $${PARAM[1]} ; \
	  ) ; \
	done

GIT--subproject--fetch::
	@for SUBPROJECT in $(filter GIT:%,$(SUBPROJECTLIST)) ; do \
	  PARAM=($$(echo $$SUBPROJECT | tr ':' ' ')) ; \
	  ( cd $${PARAM[3]} \
	    && $(GIT-FETCH) $(REPOSITORY) $${PARAM[1]} ; \
	  ) ; \
	done

GIT--subproject--pull::
	@for SUBPROJECT in $(filter GIT:%,$(SUBPROJECTLIST)) ; do \
	  PARAM=($$(echo $$SUBPROJECT | tr ':' ' ')) ; \
	  ( cd $${PARAM[3]} \
	    && $(GIT-FETCH) $(REPOSITORY) $${PARAM[1]} ; \
	    && $(GIT-PULL) --no-commit . $${PARAM[1]} ; \
	  ) ; \
	done

GIT--subproject--push::
	@for SUBPROJECT in $(filter GIT:%,$(SUBPROJECTLIST)) ; do \
	  PARAM=($$(echo $$SUBPROJECT | tr ':' ' ')) ; \
	  ( cd $${PARAM[3]} \
	    && $(GIT-PUSH) $(REPOSITORY) \
	      $${PARAM[2]}--local:$${PARAM[2]}--$(IDENT) ; \
	  ) ; \
	done

 ---->8----  ---->8----  ---->8----  ---->8----  ---->8----  ---->8----

The example Makefile code has a number of limitations: There is no error
handling. It only handles Git managed subprojects. There are other Git
commands that can be usefully applied to subprojects.
