From: Michal Novotny <minovotn@redhat.com>
Subject: [PATCH] Implement ACL module architecture and sample MySQL ACL module
Date: Tue, 14 Aug 2012 11:59:25 +0200
Message-ID: <feafacf49186d7cf0eed0002a82289b318f56ff8.1344938189.git.minovotn@redhat.com>
Cc: Michal Novotny <minovotn@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 11:59:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1DuR-0005Ib-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 11:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640Ab2HNJ7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 05:59:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755588Ab2HNJ72 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 05:59:28 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7E9xSn1019456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Tue, 14 Aug 2012 05:59:28 -0400
Received: from miglaptop.brq.redhat.com.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7E9xQ0M004412;
	Tue, 14 Aug 2012 05:59:27 -0400
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203396>

Hi,
this is the patch to introduce the ACL module architecture into git
versioning system. The variable of GIT_BASE_DIR is being used to seek
for the modules if available. If variable is unset then daemon looks
for the /etc/git-daemon.conf file existence and reads the
'base_path' key if it exists to determine the root path for
the git-daemon. This will be referred to as to $GIT_BASE_DIR
directory and the ACL modules subdirectory should reside in path of
$GIT_BASE_DIR/modules/acl. For MySQL connection you have to
alter the modules/config/modgitacl_mysql.cfg file to be able
to connect to the MySQL server using your credentials.

For MySQL database connection 2 new tables will get created
on your server and in the desired database. One holds the
ACLs for IP addresses and repositories and the second is
optional logging to the history table. This is by default
disabled however it could be enabled by setting the "log_history"
column of the git_access_acl entry to 1.

The patch also introduces the global_access_rule key to the config
which defines the default access policy if address and repository
key combination doesn't exist in the database. This automatically
creates the default access rule for the repository (which is
basically an entry with addr field set to '%' as all possible
entries in this column) based on the key settings.

The search algorithm for the entries is as follows:
1) Try to find the default entry for the repository
   - If default entry doesn't exist then create it based on the
     global_access_rule key settings (if set and valid)
2) Try to find entry for repository and IP address to override
   default settings
3) Log entries access if appropriate

If the new default access rule is being created then logging is
enabled for 'deny' global_access_rule and disabled for 'allow'
global_access_rule settings.

The MySQL module is just the working example of how to use the
ACL architecture so it's not being compiled by default and user
has to compile it manually. Basically this module is showing how
git ACL infrastructure works and it's good point to start writing
such modules.

The patch has been tested using following command line on one terminal:

$ make && (cd modules/acl && make && cd -) && GIT_BASE_DIR=`pwd` ./git-daemon --export-all

and cloning the existing repository on the second terminal with testing
all possible options in the database (using the sample MySQL module)
and everything was working fine.

Thanks,
Michal

Signed-off-by: Michal Novotny <minovotn@redhat.com>
---
 Makefile                           |   1 +
 daemon.c                           | 123 +++++++++++++++++++++
 modules/acl/Makefile               |   6 ++
 modules/acl/modgitacl_mysql.c      | 211 +++++++++++++++++++++++++++++++++++++
 modules/config/modgitacl_mysql.cfg |  12 +++
 modules/modules.h                  |   9 ++
 6 files changed, 362 insertions(+)
 create mode 100644 modules/acl/Makefile
 create mode 100644 modules/acl/modgitacl_mysql.c
 create mode 100644 modules/config/modgitacl_mysql.cfg
 create mode 100644 modules/modules.h

diff --git a/Makefile b/Makefile
index 6b0c961..6fe32a7 100644
--- a/Makefile
+++ b/Makefile
@@ -932,6 +932,7 @@ ifeq ($(uname_S),OSF1)
 	NO_NSEC = YesPlease
 endif
 ifeq ($(uname_S),Linux)
+	BASIC_CFLAGS += -ldl -rdynamic
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
diff --git a/daemon.c b/daemon.c
index ab21e66..8a06c05 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,9 +1,14 @@
+#define	GIT_DAEMON_CONFIG_FILE			"/etc/git-daemon.conf"
+#define	GIT_DAEMON_CONFIG_FILE_PATH_KEY		"base_path"
+#define	BUFSIZE					1 << 12
+
 #include "cache.h"
 #include "pkt-line.h"
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "modules/modules.h"
 
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
@@ -256,6 +261,117 @@ static int daemon_error(const char *dir, const char *msg)
 	return -1;
 }
 
+static char* daemon_read_config(const char *filename, char *key)
+{
+	FILE *fp;
+	char line[BUFSIZE];
+
+	fp = fopen(filename, "r");
+	if (fp == NULL)
+		return NULL;
+
+	while (!feof(fp)) {
+		fgets(line, sizeof(line), fp);
+
+		if (strncmp(line, key, strlen(key)) == 0) {
+			return strdup( line + strlen(key) + 3 );
+		}
+	}
+	fclose(fp);
+
+	return NULL;
+}
+
+static int check_access_addrdir(char *libname, char *base_path, char *addr, const char *dir)
+{
+	int ret = -EPERM;
+	void *lib = NULL;
+	void *pCheck = NULL;
+	typedef int (*tCheckFunc) (char *base_path, char *addr, const char *dir);
+
+	lib = dlopen(libname, RTLD_LAZY);
+	if (lib == NULL) {
+		logerror("%s: Cannot load ACL library '%s'", __FUNCTION__, libname);
+		goto cleanup;
+	}
+
+	pCheck = dlsym(lib, "check_access_addrdir");
+	if (pCheck == NULL) {
+		logerror("%s: Cannot read check_access_addrdir symbol from ACL library %s",
+			__FUNCTION__, libname);
+		goto cleanup;
+	}
+
+	tCheckFunc fCheck = (tCheckFunc) pCheck;
+	if (fCheck == NULL)
+		goto cleanup;
+
+	ret = fCheck(base_path, addr, dir);
+
+	if (ret == -EINVAL) {
+		logerror("%s: Module '%s' complained about invalid parameters. Allowing access for now",
+			__FUNCTION__, libname);
+		ret = 0;
+		goto cleanup;
+	}
+
+cleanup:
+	if (lib != NULL)
+		dlclose(lib);
+
+	return ret;
+}
+
+static int check_access_by_all_modules(const char *dir)
+{
+	char fn[NAME_MAX+1];
+	char *directory = NULL;
+	char *daemon_path = NULL;
+	struct dirent *entry;
+	int ret = -EPERM;
+	DIR *d;
+	
+	if (getenv(GIT_BASE_DIR_ENVVAR_NAME) != NULL) {
+		daemon_path = strdup( getenv(GIT_BASE_DIR_ENVVAR_NAME) );
+		snprintf(fn, sizeof(fn), "%s/modules/acl", daemon_path);
+	}
+	else {
+		if (access(GIT_DAEMON_CONFIG_FILE, R_OK) == 0) {
+			if ((daemon_path = daemon_read_config(GIT_DAEMON_CONFIG_FILE,
+				GIT_DAEMON_CONFIG_FILE_PATH_KEY)) == NULL)
+				return daemon_error("Cannot read config file %s",
+							GIT_DAEMON_CONFIG_FILE);
+
+			TRIM_LAST_CHAR_RETURN(daemon_path);
+
+			snprintf(fn, sizeof(fn), "%s/modules/acl", daemon_path);
+		}
+		else {
+			logerror("%s: Cannot open module path. Please include '%s' key into '%s' file",
+					__FUNCTION__, GIT_DAEMON_CONFIG_FILE_PATH_KEY, GIT_DAEMON_CONFIG_FILE);
+			return 0;
+		}
+	}
+
+	directory = strdup(fn);
+
+	d = opendir(directory);
+	if (d == NULL)
+		return 0;
+
+	setenv(GIT_BASE_DIR_ENVVAR_NAME, directory, 1);
+	while ((entry = readdir(d)) != NULL) {
+		if (strstr(entry->d_name, ".so") != NULL) {
+			snprintf(fn, sizeof(fn), "%s/%s", directory, entry->d_name);
+			if ((ret = check_access_addrdir(fn, daemon_path, getenv("REMOTE_ADDR"), dir)) < 0)
+				break;
+		}
+	}
+
+	closedir(d);
+	return ret;
+}
+
 static int run_service(char *dir, struct daemon_service *service)
 {
 	const char *path;
@@ -289,6 +405,13 @@ static int run_service(char *dir, struct daemon_service *service)
 		return daemon_error(dir, "repository not exported");
 	}
 
+	/* Address-based and repository-based access */
+	if (check_access_by_all_modules( dir ) != 0) {
+		logerror("'%s': repository access denied", path);
+		errno = EACCES;
+		return daemon_error(dir, "repository access denied");
+	}
+
 	if (service->overridable) {
 		service_looking_at = service;
 		service_enabled = -1;
diff --git a/modules/acl/Makefile b/modules/acl/Makefile
new file mode 100644
index 0000000..2b5cd7e
--- /dev/null
+++ b/modules/acl/Makefile
@@ -0,0 +1,6 @@
+all:	gitacl_mysql
+
+gitacl_mysql:
+	$(CC) -c -fPIC modgitacl_mysql.c
+	$(CC) -shared -fPIC -o modgitacl_mysql.so modgitacl_mysql.o `mysql_config --libs` `mysql_config --cflags`
+	rm -f modgitacl_mysql.o
diff --git a/modules/acl/modgitacl_mysql.c b/modules/acl/modgitacl_mysql.c
new file mode 100644
index 0000000..f58eeba
--- /dev/null
+++ b/modules/acl/modgitacl_mysql.c
@@ -0,0 +1,211 @@
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+#include <mysql/mysql.h>
+#include "../modules.h"
+
+#define BUFSIZE		1 << 13
+#define DEFAULT_TABLE_ACL	"git_access_acl"
+#define DEFAULT_TABLE_HISTORY	"git_access_history"
+#define CONFIG_FILE		"modgitacl_mysql.cfg"
+
+#define	REPO_ACCESS_UNSET	0x00
+#define	REPO_ACCESS_UNKNOWN	0x01
+#define	REPO_ACCESS_ALLOW	0x02
+#define	REPO_ACCESS_DENY	0x04
+
+char	*base_path = NULL;
+int	globalRepositoryAccess = REPO_ACCESS_UNSET;
+
+/* MySQL Database related settings */
+char	*server = NULL;
+char	*username = NULL;
+char	*password = NULL;
+char	*database = NULL;
+char	*table_acl = NULL;
+char	*table_history = NULL;
+
+int ensure_table_exists(MYSQL sql)
+{
+	char qry[BUFSIZE];
+
+	/* Ensure ACL table existence */
+	snprintf(qry, sizeof(qry), "CREATE TABLE IF NOT EXISTS %s (id int(11) AUTO_INCREMENT, addr varchar(128) NOT NULL, repository varchar(255) NOT NULL, "
+					"enabled tinyint(1) NOT NULL DEFAULT '1',  log_history tinyint(1) NOT NULL DEFAULT '0', added timestamp NOT NULL "
+					"DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (id))",
+					table_acl ? table_acl : DEFAULT_TABLE_ACL);
+
+	mysql_real_query(&sql, qry, strlen(qry));
+
+	/* Ensure history table existence */
+	snprintf(qry, sizeof(qry), "CREATE TABLE IF NOT EXISTS %s (id int(11) AUTO_INCREMENT, addr varchar(128) NOT NULL, repository varchar(255) NOT NULL, "
+					" granted tinyint(1) NOT NULL, time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (id))",
+					table_history ? table_history : DEFAULT_TABLE_HISTORY);
+
+	mysql_real_query(&sql, qry, strlen(qry));
+}
+
+int load_mysql_settings()
+{
+	char cfgfile[BUFSIZE];
+	char line[BUFSIZE];
+	FILE *fp;
+
+	if (base_path == NULL)
+		return -EINVAL;
+
+	snprintf(cfgfile, sizeof(cfgfile), "%s/modules/config/%s", base_path, CONFIG_FILE);
+	fp = fopen(cfgfile, "r");
+	if (fp == NULL)
+		return -EPERM;
+
+	while (!feof(fp)) {
+		fgets(line, sizeof(line), fp);
+
+		if (strncmp(line, "Server = ", 9) == 0)
+			server = strdup( line + 9 );
+		else
+		if (strncmp(line, "Username = ", 11) == 0)
+			username = strdup( line + 11 );
+		else
+		if (strncmp(line, "Password = ", 11) == 0)
+			password = strdup( line + 11 );
+		else
+		if (strncmp(line, "Database = ", 11) == 0)
+			database = strdup( line + 11 );
+		else
+		if (strncmp(line, "Table_acl = ", 12) == 0)
+			table_acl = strdup( line + 12 );
+		else
+		if (strncmp(line, "Table_history = ", 16) == 0)
+			table_history = strdup( line + 16 );
+		else
+		if (strncmp(line, "Global_access_rule = ", 21) == 0) {
+			char *tmp = strdup( line + 21 );
+
+			if (strncmp(tmp, "allow", 5) == 0)
+				globalRepositoryAccess = REPO_ACCESS_ALLOW;
+			else
+			if (strncmp(tmp, "deny", 4) == 0)
+				globalRepositoryAccess = REPO_ACCESS_DENY;
+			else
+				globalRepositoryAccess = REPO_ACCESS_UNKNOWN;
+
+			free(tmp);
+		}
+	}
+	fclose(fp);
+
+	TRIM_LAST_CHAR_RETURN(server);
+	TRIM_LAST_CHAR_RETURN(username);
+	TRIM_LAST_CHAR_RETURN(password);
+	TRIM_LAST_CHAR_RETURN(database);
+	TRIM_LAST_CHAR_RETURN(table_acl);
+	TRIM_LAST_CHAR_RETURN(table_history);
+
+	return 0;
+}
+
+void free_all(void)
+{
+	free(server);
+	free(username);
+	free(password);
+	free(database);
+	free(table_acl);
+	free(table_history);
+
+	server = NULL;
+	username = NULL;
+	password = NULL;
+	database = NULL;
+	table_acl = NULL;
+	table_history = NULL;
+}
+
+int check_access_addrdir(char *daemon_base_path, char *addr, char *dir)
+{
+	MYSQL sql;
+	MYSQL_RES *res;
+	MYSQL_ROW row;
+	int ret = 0;
+	int log = 0;
+	char qry[BUFSIZE];
+
+	base_path = (daemon_base_path ? daemon_base_path : getenv(GIT_BASE_DIR_ENVVAR_NAME));
+	if (base_path == NULL)
+		return ret;
+
+	if (mysql_init(&sql) == NULL)
+		return ret;
+
+	if (load_mysql_settings() != 0)
+		goto cleanup;
+
+	if (globalRepositoryAccess == REPO_ACCESS_UNKNOWN) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (!mysql_real_connect(&sql, server, username, password, database, 0, NULL, 0))
+		return ret;
+
+	ensure_table_exists(sql);
+
+	/* Check the default settings for repository */
+	snprintf(qry, sizeof(qry), "SELECT enabled, log_history FROM %s WHERE addr = '%%' AND repository = '%s'",
+				table_acl ? table_acl : DEFAULT_TABLE_ACL, dir);
+
+	if (mysql_real_query(&sql, qry, strlen(qry)) != 0)
+		goto cleanup;
+
+	res = mysql_store_result(&sql);
+	if (mysql_num_rows(res) > 0) {
+		row = mysql_fetch_row(res);
+		ret = (atoi(row[0]) == 1) ? 0 : -EPERM;
+		log = atoi(row[1]);
+	}
+	else
+	if (globalRepositoryAccess != REPO_ACCESS_UNSET) {
+		snprintf(qry, sizeof(qry), "INSERT INTO %s(addr, repository, enabled, log_history) VALUES('%%', '%s', %d, %d)",
+			table_acl ? table_acl : DEFAULT_TABLE_ACL, dir,
+			(globalRepositoryAccess == REPO_ACCESS_ALLOW),
+			(globalRepositoryAccess == REPO_ACCESS_DENY));
+
+		mysql_real_query(&sql, qry, strlen(qry));
+
+		ret = (globalRepositoryAccess == REPO_ACCESS_ALLOW) ? 0 : -EPERM;
+		log = (ret < 0);
+	}
+	mysql_free_result(res);
+
+	/* Check the settings for IP address of access */
+	snprintf(qry, sizeof(qry), "SELECT enabled, log_history FROM %s WHERE addr = '%s' AND repository = '%s'",
+				table_acl ? table_acl : DEFAULT_TABLE_ACL, addr, dir);
+
+	if (mysql_real_query(&sql, qry, strlen(qry)) != 0)
+		goto cleanup;
+
+	res = mysql_store_result(&sql);
+	if (mysql_num_rows(res) > 0) {
+		row = mysql_fetch_row(res);
+		ret = (atoi(row[0]) == 1) ? 0 : -EPERM;
+		log = atoi(row[1]);
+	}
+	mysql_free_result(res);
+
+	/* If logging is enabled then log to the history table */
+	if (log) {
+		snprintf(qry, sizeof(qry), "INSERT INTO %s(addr, repository, granted) VALUES('%s', '%s', %d)",
+				table_history ? table_history : DEFAULT_TABLE_HISTORY, addr, dir, (ret == 0) ? 1 : 0);
+		mysql_real_query(&sql, qry, strlen(qry));
+	}
+
+cleanup:
+	free_all();
+	mysql_close(&sql);
+
+	return ret;
+}
+
diff --git a/modules/config/modgitacl_mysql.cfg b/modules/config/modgitacl_mysql.cfg
new file mode 100644
index 0000000..e371f4e
--- /dev/null
+++ b/modules/config/modgitacl_mysql.cfg
@@ -0,0 +1,12 @@
+# MySQL server settings
+Server = <server>
+Username = <username>
+Password = <password>
+Database = <database>
+
+# Table names, those are default values
+Table_acl = git_access_acl
+Table_history = git_access_history
+
+# Global access rule can be only 'allow' or 'deny'
+Global_access_rule = allow
diff --git a/modules/modules.h b/modules/modules.h
new file mode 100644
index 0000000..54c61dd
--- /dev/null
+++ b/modules/modules.h
@@ -0,0 +1,9 @@
+#ifndef GIT_MODULES
+#define GIT_MODULES
+
+#include <dlfcn.h>
+#define GIT_BASE_DIR_ENVVAR_NAME	"GIT_BASE_DIR"
+#define TRIM_LAST_CHAR(x)		x[ strlen(x) - 1 ] = 0;
+#define TRIM_LAST_CHAR_RETURN(x)	if (x[strlen(x)-1] == '\n') x[ strlen(x) - 1 ] = 0;
+
+#endif
-- 
1.7.11.2
